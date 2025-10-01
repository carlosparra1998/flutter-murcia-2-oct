import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_murcia_2_oct/app/utils/env.dart';

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

  bool _isNotPrimitiveData<T>() =>
      T != Map && T != String && T != num && T != bool;

  Future<HttpResponse<T>> call<T>(
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

    try {
      if (_isNotPrimitiveData<T>() && base == null) {
        throw EndpointCallError('No object error');
      }

      response = await _getResponse<T>(
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

  Future<Response<T>> _getResponse<T>(
    HttpCall method,
    String endpoint,
    bool tokenRequired,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    dynamic base,
  ) async {
    switch (method) {
      case HttpCall.get:
        return (await api.get(
          endpoint,
          queryParameters: queryParameters,
          options: Options(
            extra: {'tokenRequired': tokenRequired, 'base': base},
          ),
        ));

      case HttpCall.post:
        return (await api.post<T>(
          endpoint,
          queryParameters: queryParameters,
          data: data,
          options: Options(
            extra: {'tokenRequired': tokenRequired, 'base': base},
          ),
        ));

      case HttpCall.delete:
        return (await api.delete(
          endpoint,
          queryParameters: queryParameters,
          data: data,
          options: Options(
            extra: {'tokenRequired': tokenRequired, 'base': base},
          ),
        ));

      case HttpCall.put:
        return (await api.put(
          endpoint,
          queryParameters: queryParameters,
          data: data,
          options: Options(
            extra: {'tokenRequired': tokenRequired, 'base': base},
          ),
        ));
    }
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
