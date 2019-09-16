import 'package:dio/dio.dart';
import 'package:flutter_bloc_demo/src/Utils/app_security.dart';
import 'package:flutter_bloc_demo/src/models/authentication_model.dart';
import 'package:flutter_bloc_demo/src/models/base_model.dart';
import 'dart:convert';

import 'package:flutter_bloc_demo/src/resources/user_repository.dart';

enum HttpMethod {
  GET, POST, PUT, DELETE
}

class TestContructor { 
  init() async {
    print("heheh 1");
    await Future.delayed(Duration(seconds: 2));
    print("heheh 2");
  }
}

class RequestManager<T extends BaseModel> {
  static final shared = RequestManager();
  Dio dio;
  Dio dioNotAccessToken;
  BaseOptions options;

  RequestManager._internal();

  static Future<RequestManager> getInstance() async {
    return RequestManager._internal();
  }

  final baseUrl = "https://reqres.in/";

  init() async {
    dio = Dio();
    dioNotAccessToken = Dio(); // We can using this for call API not token.
    final appSecurity = await AppSecurity.getInstance();
    final bool hasToken = await appSecurity.hasToken();
    final String token = await appSecurity.token();

    if (hasToken) {
      dio.options.headers = {
        "authorization": token
      };
    }

    // retry request. Chưa test :v 
    
    // dio.interceptors.add(InterceptorsWrapper(onError: (DioError error) async {
    //   if (error.response.statusCode == 401) {
    //     dio.lock();
    //     dio.interceptors.responseLock.lock();
    //     dio.interceptors.errorLock.lock();

    //     AuthenticationModel response = await UserRepository().refreshToken()
    //     .whenComplete(() {
    //       dio.unlock();
    //       dio.interceptors.responseLock.unlock();
    //       dio.interceptors.errorLock.unlock();
    //     });

    //     final String token = response.token;
    //     RequestOptions options = error.response.request;
    //     options.headers = {
    //       "authorization": token
    //     };
    //     return dio.request(options.path, options: options);
    //   }
    //   return error;
    // }));
  }

  RequestManager() {
    // TODO
  }

  Future<T> baseRequestWidthModel(String path, HttpMethod method, {Map<String, dynamic> parameter}) async {
    Response response;
    final String url = baseUrl + path;

    try {
      switch (method) {
        case HttpMethod.POST:
          response = await dio.post(url, data: parameter);
          break;
        default:
          break;
      }
      final dataJson = json.decode(response.data);
      final model = BaseModel.fromJson(dataJson);
      return model;
    } on DioError catch(e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> baseRequest(String path,
      HttpMethod method,
      {Map<String, dynamic> parameter}) async {

    Response response;

    final String url = baseUrl + path;

    try {
      switch (method) {
        case HttpMethod.POST:
          response = await dio.post(url, data: parameter);
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