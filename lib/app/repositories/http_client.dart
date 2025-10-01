import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_murcia_2_oct/app/utils/env.dart';
import 'package:flutter_murcia_2_oct/app/utils/general_utils.dart';

import 'http_response.dart';

enum HttpCall { get, post, put, delete }

class HttpClient {
  final Dio api = Dio(
    BaseOptions(
      connectTimeout: Duration(milliseconds: 15000),
      receiveTimeout: Duration(milliseconds: 15000),
      sendTimeout: Duration(milliseconds: 15000),
    ),
  );

  HttpClient() {
    api.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
        onResponse: _onResponse,
      ),
    );
    if (!kIsWeb) {
      final adapter = api.httpClientAdapter;
      if (adapter is IOHttpClientAdapter) {
        adapter.onHttpClientCreate = (io.HttpClient dioClient) {
          dioClient.badCertificateCallback = (_, __, ___) => true;
          return dioClient;
        };
      }
    }
  }

  Future<HttpResponse<T>> call<T, R>(
    String endpoint, {
    HttpCall method = HttpCall.get,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool tokenRequired = true,
    dynamic base,
  }) async {
    String? errorMessage;
    bool error = false;
    Response<T>? response;

    base = base is R ? base : null;

    try {
      if (isNotPrimitiveData<T>() && base == null) {
        throw EndpointCallError('No object base error');
      }

      response = await _getResponse<T, R>(
        method,
        endpoint,
        tokenRequired,
        queryParameters,
        data,
        base,
      );
    } on DioError catch (e) {
      errorMessage = _getErrorMessage(e);
      error = true;
    } on EndpointCallError catch (e) {
      errorMessage = e.cause;
      error = true;
    } on Exception catch (_) {
      error = true;
    }

    return HttpResponse<T>(
      data: response?.data,
      errorMessage: errorMessage,
      hasError: error,
    );
  }

  void _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.baseUrl = Env.API_URL ?? '';

    String? token = 'AQUI_ESTARÁ_EL_ACCESS_TOKEN_SI_ES_REQUERIDO';

    // ignore: unnecessary_null_comparison
    if (options.extra['tokenRequired'] && token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  void _onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.requestOptions.extra['base'] != null) {
      if (response.data is Map<String, dynamic>) {
        response.data = response.requestOptions.extra['base'].base.fromJson(
          response.data,
        );
      }
      if (response.data is List) {
        response.data =
            response.data.map((e) {
              final base = response.requestOptions.extra['base'].base;
              return base.fromJson(e);
            }).toList();
      }
    }

    handler.next(response);
  }

  void _onError(DioError error, ErrorInterceptorHandler handler) async {
    int? statusCode = error.response?.statusCode;
    print(statusCode);
    print(_getErrorMessage(error));

    handler.next(error);
  }

  Future<Response<T>> _getResponse<T, R>(
    HttpCall method,
    String endpoint,
    bool tokenRequired,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    dynamic base,
  ) async {
    Response response;

    switch (method) {
      case HttpCall.get:
        response = (await api.get(
          endpoint,
          queryParameters: queryParameters,
          options: Options(
            extra: {'tokenRequired': tokenRequired, 'base': base},
          ),
        ));

      case HttpCall.post:
        response = (await api.post(
          endpoint,
          queryParameters: queryParameters,
          data: data,
          options: Options(
            extra: {'tokenRequired': tokenRequired, 'base': base},
          ),
        ));

      case HttpCall.delete:
        response = (await api.delete(
          endpoint,
          queryParameters: queryParameters,
          data: data,
          options: Options(
            extra: {'tokenRequired': tokenRequired, 'base': base},
          ),
        ));

      case HttpCall.put:
        response = (await api.put(
          endpoint,
          queryParameters: queryParameters,
          data: data,
          options: Options(
            extra: {'tokenRequired': tokenRequired, 'base': base},
          ),
        ));
    }

    T? dataResponse;

    if (T == R && response.data is List) {
      throw EndpointCallError(
        'Tipado incorrecto. Se recibe un List y esperas un Object',
      );
    }

    if (T != R && response.data is! List) {
      dataResponse = [response.data as R] as T;
    } else {
      dataResponse =
          T != R
              ? List<R>.from(response.data.map((e) => e as R)) as T
              : response.data;
    }

    return Response<T>(
      data: dataResponse,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
      headers: response.headers,
    );
  }

  String _getErrorMessage(DioError error) {
    try {
      String msg =
          error.response?.data['message'] != null
              ? '${error.response?.data['message']}'
              : error.response?.data['detail'] is String
              ? error.response?.data['detail']
              : error.response?.data['detail'][0]['msg'];

      return msg;
    } catch (_) {
      return 'Error en el servicio';
    }
  }
}
