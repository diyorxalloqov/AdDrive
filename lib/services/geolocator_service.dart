import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_texi_tracker/services/firebase_location_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:yandex_mapkit/yandex_mapkit.dart';

ValueNotifier<List<geocoding.Placemark>?> addressNotifier = ValueNotifier(null);

class GeoLocatorService {
  // static const geo = Geolocator();
  bool isTry = true;
  FirebaseLocationService serviceFirebaseLocationService  = FirebaseLocationService();
  // var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 30,timeInterval: 40000);

  //get current position
  Stream<Position> getCoords() {

    LocationSettings settings = const LocationSettings(distanceFilter: 15,accuracy: LocationAccuracy.high,);

    return Geolocator.getPositionStream(locationSettings: settings);
  }
  //get current future
  Future<Position?> getCordFuture() {
    return Geolocator.getLastKnownPosition();
  }
  Future<Position?> getLastKnownPosition(){
    return Geolocator.getLastKnownPosition();
  }

  ///get address by position
  Future<List<geocoding.Placemark>?> getAddress(Position position) async {
    addressNotifier.value = await GeocodingPlatform.instance?.placemarkFromCoordinates(position.latitude, position.longitude);
    addressNotifier.notifyListeners();
    return addressNotifier.value;
  }

  ///calculate distance
  Future<double> getDistance(Point origin, Point destination) async {
    return Geolocator.distanceBetween(origin.latitude, origin.longitude,
        destination.latitude, destination.longitude);
  }
}
