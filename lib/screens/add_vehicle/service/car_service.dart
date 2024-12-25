/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_texi_tracker/data/api/api_provider.dart';
import 'package:flutter_texi_tracker/global/services/request_service.dart';
import 'package:flutter_texi_tracker/screens/add_vehicle/model/car_details_model.dart';
import 'package:flutter_texi_tracker/screens/add_vehicle/model/car_model.dart';

class CarsService {
  Future<Either<String, List<CarModel>>> getAllCars() async {
    try {
      Either<String, Response> res =
          await RequestService().getRequest(ApiProvider.getCars);

      return res.fold(
        (errorMessage) => left(errorMessage),
        (response) {
          List<CarModel> cars =
              (response.data as List).map((e) => CarModel.fromJson(e)).toList();
          return right(cars);
        },
      );
    } on DioException catch (e) {
      return left(e.message.toString());
    } catch (e) {
      return left("Unexpected error: ${e.toString()}");
    }
  }

  Future<Either<String, List<CarDetailsModel>>> getCarDetails(String id) async {
    try {
      Either<String, Response> res =
          await RequestService().getRequest("${ApiProvider.getCarDetails}/$id");

      return res.fold(
        (errorMessage) => left(errorMessage),
        (response) {
          List<CarDetailsModel> cars = (response.data as List)
              .map((e) => CarDetailsModel.fromJson(e))
              .toList();
          return right(cars);
        },
      );
    } on DioException catch (e) {
      return left(e.message.toString());
    } catch (e) {
      return left("Unexpected error: ${e.toString()}");
    }
  }
}
