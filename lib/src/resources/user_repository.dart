import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_demo/src/Utils/app_security.dart';
import 'package:flutter_bloc_demo/src/models/authentication_model.dart';
import 'package:flutter_bloc_demo/src/networks/request_manager.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<AuthenticationModel> authenticate(String email, String password) async {
    print("UserRepository login $email $password");
    try {
      final data = await RequestManager.shared
          .baseRequest("api/login", HttpMethod.POST, parameter: {
        "email": email,
        "password": password
      });

      final authenModel = AuthenticationModel.fromJson(data);

      return authenModel;
    } catch (err) {
      throw err;
    }
  }

  Future<void> logout() async {
    print("UserRepository logout");
    await Future.delayed(Duration(seconds: 2));
    return;
  }
}