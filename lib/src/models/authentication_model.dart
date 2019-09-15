class AuthenticationModel {
  String token;

  AuthenticationModel.fromJson(parsedjson) {
    this.token = parsedjson['token'];
  }
}