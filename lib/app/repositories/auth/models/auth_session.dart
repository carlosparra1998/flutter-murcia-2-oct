import 'package:flutter_murcia_2_oct/app/repositories/response_model.dart';

class AuthSession extends ResponseModel<AuthSession> {
  final String? accessToken;
  final String? refreshToken;

  AuthSession({
    this.accessToken,
    this.refreshToken,
  });

  @override
  AuthSession fromJson(Map<String, dynamic> json) {
    return AuthSession(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  @override
  AuthSession get base => AuthSession();
}
