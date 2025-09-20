import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'http_response.dart';
import 'response_model.dart';

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

  bool _isNotPrimitiveData<T>() => T != Map && T != String && T != num;

  Future<HttpResponse<T, R>> call<T, R>(
    String endpoint, {
    HttpCall method = HttpCall.get,
    ResponseModel<R>? object,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool tokenRequired = true,
  }) async {
    String? errorMessage;
    bool error = false;
    bool connError = false;
    T? dataResult;

    try {
      if (_isNotPrimitiveData<T>() && object == null) {
        //throw EndpointCallError('No object error');
      }

      dynamic response;

      switch (method) {
        case HttpCall.get:
          response = await _get(
            endpoint,
            tokenRequired,
            queryParameters,
          );
          break;

        case HttpCall.post:
          response = await _post(
            endpoint,
            tokenRequired,
            queryParameters,
            data,
          );
          break;

        case HttpCall.delete:
          response = await _delete(
            endpoint,
            tokenRequired,
            queryParameters,
            data,
          );
          break;

        case HttpCall.put:
          response = await _put(endpoint, tokenRequired, queryParameters, data);
          break;
      }

      if (_isNotPrimitiveData<T>()) {
        if (response is Map<String, dynamic>) {
          dataResult = object!.fromJson(response) as T;
        }
        if (response is List) {
          dataResult = response.map((e) => object!.fromJson(e)).toList() as T;
        }
      } else {
        dataResult = response as T;
      }
    } on DioError catch (e) {
      errorMessage = e.message;
      error = true;
    } on EndpointCallError catch (e) {
      errorMessage = e.cause;
      error = true;
    } on Exception catch (_) {
      error = true;
    }

    return HttpResponse<T, R>(
      data: dataResult,
      errorMessage: errorMessage,
      hasError: error,
    );
  }

  Future<dynamic> _get(
    String endpoint,
    bool tokenRequired,
    Map<String, dynamic>? queryParameters,
  ) async {
    return (await api.get(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        extra: {'tokenRequired': tokenRequired},
      ),
    )).data;
  }

  Future<dynamic> _post(
    String endpoint,
    bool tokenRequired,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  ) async {
    return (await api.post(
      endpoint,
      queryParameters: queryParameters,
      data: data,
      options: Options(extra: {'tokenRequired': tokenRequired}),
    )).data;
  }

  Future<dynamic> _put(
    String endpoint,
    bool tokenRequired,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  ) async {
    return (await api.put(
      endpoint,
      queryParameters: queryParameters,
      data: data,
      options: Options(extra: {'tokenRequired': tokenRequired}),
    )).data;
  }

  Future<dynamic> _delete(
    String endpoint,
    bool tokenRequired,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  ) async {
    return (await api.delete(
      endpoint,
      queryParameters: queryParameters,
      data: data,
      options: Options(extra: {'tokenRequired': tokenRequired}),
    )).data;
  }

  void _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.baseUrl = dotenv.env['API_URL']! + dotenv.env['API_VERSION']!;

    String? token = 'token';

    if (options.extra['tokenRequired'] && token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  void _onError(DioError error, ErrorInterceptorHandler handler) async {
    int? statusCode = error.response?.statusCode;

    try {
      String msg =
          error.response?.data['message'] != null
              ? '${error.response?.data['message']}'
              : error.response?.data['detail'] is String
              ? error.response?.data['detail']
              : error.response?.data['detail'][0]['msg'];

      print('$msg$statusCode');
    } catch (_) {
      print('Error en el servicio');
    }

    handler.next(error);
  }

  void _onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }
}
