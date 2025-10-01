import 'package:dio/dio.dart';
import 'package:flutter_murcia_2_oct/app/repositories/auth/models/auth_session.dart';
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
  }

  Future<HttpResponse<T>> call<T, R>(
    String endpoint, {
    HttpCall method = HttpCall.get,
    dynamic data,
    bool tokenRequired = true,
  }) async {
    String? errorMessage;
    bool error = false;
    Response<T>? response;

    Options options = Options(
      extra: {'tokenRequired': tokenRequired, 'type': R},
    );

    try {
      switch (method) {
        case HttpCall.get:
          response = (await api.get(endpoint, options: options));

        case HttpCall.post:
          response = (await api.post(endpoint, data: data, options: options));
        default:
          response = null; //IMPLEMENTAR RESTO DE VERBOS
      }
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
    Type type = response.requestOptions.extra['type'];

    if (response.data is Map<String, dynamic>) {
      response.data = getObject(type, response.data);
    }
    if (response.data is List) {
      response.data = getObjects(type, response.data);
    }

    handler.next(response);
  }

  void _onError(DioError error, ErrorInterceptorHandler handler) async {
    int? statusCode = error.response?.statusCode;
    print(statusCode);
    print(_getErrorMessage(error));

    handler.next(error);
  }

  dynamic getObject(Type type, dynamic data) {
    switch (type) {
      case AuthSession:
        return AuthSession.fromJson(data);
      /* 
      case Clase1:
        return Clase1.fromJson(data);
      case Clase2:
        return Clase2.fromJson(data);
      case Clase3:
        return Clase3.fromJson(data);
      */
    }

    return null;
  }

  dynamic getObjects(Type type, dynamic data) {
    switch (type) {
      case int:
        return (data as List).map((e) => int.parse('$e')).toList();
      case String:
        return (data as List).map((e) => '$e').toList();
      case AuthSession:
        return (data as List).map((e) => AuthSession.fromJson(e)).toList();
      /* 
      case Clase1:
        return (data as List).map((e) => Clase1.fromJson(e)).toList();
      case Clase2:
        return (data as List).map((e) => Clase2.fromJson(e)).toList();
      case Clase3:
        return (data as List).map((e) => Clase3.fromJson(e)).toList();
      */
    }
    return null;
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
