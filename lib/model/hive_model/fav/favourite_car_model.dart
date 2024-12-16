import 'package:hive/hive.dart';

part 'favourite_car_model.g.dart';
@HiveType(typeId: 4)
class FavoriteCar extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? brandName;
  @HiveField(2)
  final String? location;
  @HiveField(3)
  final String? brandingType;
  @HiveField(4)
  final String? duration;
  @HiveField(5)
  final String? price;
  @HiveField(6)
  final String? image;

  FavoriteCar({ this.id,  this.brandName, this. location, this.brandingType, this.duration, this.price, this.image});
}