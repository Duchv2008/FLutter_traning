import 'package:dio/dio.dart';
import 'package:flutter_bloc_demo/src/Utils/app_security.dart';
import 'package:flutter_bloc_demo/src/models/authentication_model.dart';
import 'package:flutter_bloc_demo/src/models/base_model.dart';
import 'dart:convert';

import 'package:flutter_bloc_demo/src/resources/user_repository.dart';

enum HttpMethod {
  GET, POST, PUT, DELETE
}

class Constants {
  static const String BASE_URL = "https://reqres.in/";
  static const String ACCESS_TOKEN_KEY = "authorization";
}

class RequestManager {
  final _baseUrl = Constants.BASE_URL;
  Dio _dio;
  Dio _dioNotAccessToken;
  BaseOptions _options;

  RequestManager._internal({hasToken, token}) {
    _dio = Dio();
    _dioNotAccessToken = Dio();
    if (hasToken) {
      _dio.options.headers = {
        Constants.ACCESS_TOKEN_KEY: token
      };
    }
    // retry request. Chưa test :v 
    // _dio.interceptors.add(InterceptorsWrapper(onError: (DioError error) async {
    //   if (error.response.statusCode == 401) {
    //     _dio.lock();
    //     _dio.interceptors.responseLock.lock();
    //     _dio.interceptors.errorLock.lock();

    //     AuthenticationModel response = await UserRepository().refreshToken()
    //     .whenComplete(() {
    //       _dio.unlock();
    //       _dio.interceptors.responseLock.unlock();
    //       _dio.interceptors.errorLock.unlock();
    //     });

    //     final String token = response.token;
    //     RequestOptions options = error.response.request;
    //     options.headers = {
    //       "authorization": token
    //     };
    //     return _dio.request(options.path, options: options);
    //   }
    //   return error;
    // }));
  }

  static RequestManager _instance;
  static Future<RequestManager> getInstance() async {
    if (_instance == null) {
      final appSecurity = await AppSecurity.getInstance();
      final bool hasToken = await appSecurity.hasToken();
      final String token = await appSecurity.token();
      _instance = RequestManager._internal(hasToken: hasToken, token: token);
    }
    return _instance;
  }

  // Future<Map<String, dynamic>> baseRequestWidthModel(String path, HttpMethod method, {Map<String, dynamic> parameter}) async {
  //   Response response;
  //   final String url = _baseUrl + path;

  //   print("baseRequestWidthModel $url $method $parameter");

  //   try {
  //     switch (method) {
  //       case HttpMethod.POST:
  //       print("baseRequestWidthModel response");
  //         response = await _dio.post(url, data: parameter);
  //         break;
  //       default:
  //         break;
  //     }
  //     return response.data;
  //   } on DioError catch(e) {
  //     print("DioError ${e.message}");
  //     throw e;
  //   }
  // }

  Future<Map<String, dynamic>> baseRequest(String path,
      HttpMethod method,
      {Map<String, dynamic> parameter}) async {

    Response response;

    final String url = _baseUrl + path;

    try {
      switch (method) {
        case HttpMethod.POST:
          response = await _dio.post(url, data: parameter);
          break;
        default:
          break;
      }
      return response.data;
    } on DioError catch(e) {
      throw e;
    }
  }
}