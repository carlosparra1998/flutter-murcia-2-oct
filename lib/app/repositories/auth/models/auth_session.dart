class AuthSession {
  late final String? accessToken;
  late final String? refreshToken;

  AuthSession({this.accessToken, this.refreshToken});

  AuthSession.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}
