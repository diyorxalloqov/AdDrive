/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'dart:io';

import 'package:addrive/screens/add_vehicle/model/car_details_model.dart';
import 'package:addrive/screens/add_vehicle/model/car_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:addrive/global/imports/app_imports.dart';

class CarDb {
  Box<CarModel>? carBox;
  Box<CarDetailsModelMain>? carDetailsBox;

  static void registerAdapters() {
    Hive.registerAdapter(CarDetailsModelMainAdapter());
    Hive.registerAdapter(CarDetailsModelAdapter());
    Hive.registerAdapter(PathAdapter());
    Hive.registerAdapter(CarModelAdapter());
  }

  Future<void> openbox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    carBox = await Hive.openBox<CarModel>("cars");
    carDetailsBox = await Hive.openBox<CarDetailsModelMain>("carDetails");
  }

  Future<CarDetailsModelMain?> getCarDetails(String id) async {
    try {
      await openbox();
      if (carDetailsBox?.isNotEmpty ?? false) {
        debugPrint("Car details db DATA IS ${carDetailsBox!.values.toList()}");
        return carDetailsBox?.get(id);
      } else {
        return null;
      }
    } on HiveError catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<void> writeToDbCarDetails(
      CarDetailsModelMain carDetailsModelMain) async {
    try {
      await openbox();
      await carDetailsBox?.put(carDetailsModelMain.id, carDetailsModelMain);
      debugPrint("car details DATA WRITTEN ${carDetailsBox!.values.toList()}");
      debugPrint("${carDetailsBox?.length} box length");
    } on HiveError catch (e) {
      debugPrint(e.message);
    }
  }

  Future<List<CarModel>?> getCars() async {
    try {
      await openbox();
      if (carBox?.isNotEmpty ?? false) {
        debugPrint("Car db DATA IS ${carBox!.values.toList()}");
        return carBox?.values.toList();
      } else {
        return null;
      }
    } on HiveError catch (e) {
      debugPrint(e.message);
      return null;
    }
  }

  Future<void> writeToDbCars(List<CarModel> cars) async {
    try {
      await openbox();
      await carBox?.clear();
      await carBox?.addAll(cars);
      debugPrint("Vehicles DATA WRITTEN ${carBox!.values.toList()}");
      debugPrint("${carBox?.length} box length");
    } on HiveError catch (e) {
      debugPrint(e.message);
    }
  }
}
