import 'package:hive/hive.dart';
part 'user_location.g.dart';

@HiveType(typeId: 1)
class UserLocation {
  @HiveField(0)
  final latitude;
  @HiveField(1)
  final longitude;
  @HiveField(2)
  final heading;
  @HiveField(3)
  final distance;

  UserLocation({this.latitude, this.longitude, this.heading, this.distance});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['heading'] = heading;
    data['distance'] = distance;

    return data;
  }
}
