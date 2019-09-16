import 'package:flutter_bloc_demo/src/models/base_model.dart';

class AuthenticationModel extends BaseModel {
  String token;

  AuthenticationModel.fromJson(parsedJson) : super.fromJson(parsedJson) {
    this.token = parsedJson['token'];
  }
}