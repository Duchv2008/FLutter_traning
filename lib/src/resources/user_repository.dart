import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_demo/src/Utils/app_security.dart';
import 'package:flutter_bloc_demo/src/models/authentication_model.dart';
import 'package:flutter_bloc_demo/src/networks/request_manager.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<AuthenticationModel> authenticate(String email, String password) async {
    try {
      final requestManager = await RequestManager.getInstance();
      final Map<String, dynamic> dataJson = await requestManager.baseRequest("api/login", HttpMethod.POST, parameter: {
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      });
      print("dataJson $dataJson");
      return AuthenticationModel.fromJson(dataJson);
    } catch (err) {
      print("UserRepository DioError ${err.message}");
      throw err;
    }
  }

  Future<AuthenticationModel> refreshToken() async {
    return null;
  }

  Future<void> logout() async {
    print("UserRepository logout");
    await Future.delayed(Duration(seconds: 2));
    return;
  }
}