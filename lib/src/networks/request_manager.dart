import 'package:dio/dio.dart';

enum HttpMethod {
  GET, POST, PUT, DELETE
}

class RequestManager {
  static final shared = RequestManager();
  Dio dio;
  BaseOptions options;

  final baseUrl = "https://reqres.in/";

  RequestManager() {
    dio = Dio();
//    dio.interceptors.add(LogInterceptor(responseBody: false));
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