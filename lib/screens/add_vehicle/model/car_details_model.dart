/*
 *  (c) Diyor Xalloqov 2024.8.15 Toshkent, Uzbekistan
 *  github: https://github.com/diyorxalloqov
 *  LinkedIn: https://www.linkedin.com/in/diyor-xalloqov-024b63231/
 *  Telegram: https://t.me/Flutter_dart_developer
 */

import 'package:hive/hive.dart';
part 'car_details_model.g.dart';

@HiveType(typeId: 6)
class CarDetailsModelMain {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final List<CarDetailsModel>? carDetailsModel;
  const CarDetailsModelMain(this.id, this.carDetailsModel);
}

@HiveType(typeId: 7)
class CarDetailsModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? cyrillicName;
  @HiveField(3)
  String? clas;
  @HiveField(4)
  num? yearFrom;
  @HiveField(5)
  num? yearTo;
  @HiveField(6)
  Path? path;
  @HiveField(7)
  num? generations;

  CarDetailsModel(
      {this.id,
      this.name,
      this.cyrillicName,
      this.clas,
      this.yearFrom,
      this.yearTo,
      this.path,
      this.generations});

  CarDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cyrillicName = json['cyrillic-name'];
    clas = json['class'];
    yearFrom = json['year-from'];
    yearTo = json['year-to'];
    path = json['path'] != null ? Path.fromJson(json['path']) : null;
    generations = json['generations'];
  }
}

@HiveType(typeId: 8)
class Path {
  @HiveField(0)
  String? markId;
  @HiveField(1)
  Path({this.markId});

  Path.fromJson(Map<String, dynamic> json) {
    markId = json['mark-id'];
  }
}
