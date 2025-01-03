import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:addrive/controller/auth_controller.dart';
import 'http_service.dart';

class HttpServiceImpl implements HttpService {
  late Dio _dio;
  final AuthController _authController = AuthController();

  @override
  Future<Response> getRequest(String url) async {
    if (kDebugMode) {
      print(url);
    }
    Response response;
    try {
      response = await _dio.get(url);
      if (kDebugMode) {
        print('response $response');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> posRequest(String url, dynamic data) async {
    if (kDebugMode) {
      print("url $url");
      print(data);
      print('bearer ${_authController.getUser()?.accessToken}');
    }

    Response response;

    try {
      response = await _dio.post(
        url,
        data: data,
        options: Options(headers: {
          "Content-Type": "application/json;charset=UTF-8",
          'Authorization': 'Bearer ${_authController.getUser()?.accessToken}',
          'Accept': 'application/json'
        }),
      );
      if (kDebugMode) {
        print('post response ${response.data}');
        print('post statusCode ${response.statusCode}');
        print('post message ${response.statusMessage}');
      }
      if (response.statusCode == 200) {
        return response;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("${e.message} MESSAGE");
        print("${e.response?.statusMessage} MESSAGE");
      }
      throw Exception(e.response?.statusMessage);
    }
    return response;
  }

  @override
  void init() {
    _dio = Dio();
  }
}
