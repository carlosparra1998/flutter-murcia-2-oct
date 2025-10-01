import 'package:flutter_murcia_2_oct/app/repositories/auth/models/auth_session.dart';
import 'package:flutter_murcia_2_oct/app/repositories/http_client.dart';
import 'package:flutter_murcia_2_oct/app/repositories/http_response.dart';

import 'auth_endpoints.dart';

class AuthRepository {
  static HttpClient client = HttpClient();

  static Future<HttpResponse<AuthSession>> login(
    String email,
    String password,
  ) async {
    return await client.call<AuthSession, AuthSession>(
      AuthEndpoints.login,
      method: HttpCall.post,
      base: AuthSession().base,
      data: {'username': email, 'password': password},
      tokenRequired: false,
    );
  }

  static Future<HttpResponse<String>> register(String body) async {
    return await client.call<String, String>(
      AuthEndpoints.register,
      method: HttpCall.post,
      data: body,
      tokenRequired: false,
    );
  }
}
