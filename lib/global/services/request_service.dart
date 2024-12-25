/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RequestService {
  late final Dio _dio;
  RequestService() {
    _dio = Dio();
  }

  Future<Either<String, Response>> getRequest(String url) async {
    try {
      final Response response = await _dio.get(url);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return right(response);
      } else {
        return left(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      debugPrint(e.message.toString());
      return left(e.message.toString());
    }
  }
}
