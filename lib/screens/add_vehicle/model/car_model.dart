/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:hive_flutter/adapters.dart';
part 'car_model.g.dart';

@HiveType(typeId: 5)
class CarModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? cyrillicName;
  @HiveField(3)
  num? models;

  CarModel({this.id, this.name, this.cyrillicName, this.models});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cyrillicName = json['cyrillic-name'];
    models = json['models'];
  }
}
