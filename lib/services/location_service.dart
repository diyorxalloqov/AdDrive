import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/data/local_data/shared_preference.dart';
import 'package:flutter_texi_tracker/hive/hive_location_provider.dart';
import 'package:flutter_texi_tracker/model/driver_location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'firebase_location_service.dart';
import 'geolocator_service.dart';
import 'dart:io' as platform;

class LocationService {
  var location = Location();
  bool isTry = true;

  LocationService() {
    location.hasPermission().then((value) {
      if (value == PermissionStatus.granted) {
        if (platform.Platform.isAndroid) {
          location.changeSettings(interval: 3000, distanceFilter: 15);
        }
        location.enableBackgroundMode(enable: true);
        location.onLocationChanged.listen((locationData) {
          _locationController.add(locationData);
        });
      }
    });
  }

  //continuously emit location updates
  final StreamController<LocationData> _locationController =
      StreamController<LocationData>.broadcast();

  Stream<LocationData> get locationStream => _locationController.stream;

  Future<LocationData?> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      return userLocation;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  ///adding location to local database
  ///when user stop driving , data will clean
  ///from local database, please make sure that
  ///location stream stop listening when user stop driniving
  Future<void> addLocationToLocal(
      {uid,
      required DriverLocationModel model,
      required FirebaseLocationService service,
      required HiveLocationProvider locationProvider}) async {
    ///get recent trackingId from local
    final trackingIdFromLocal = await getLocalData(key: 'tracking_id');
    if(trackingIdFromLocal != 'null'){
      final geoService = GeoLocatorService();
      final lastLocationFromLocal = locationProvider.getUserLastPosition();
      double distance = 0.0;

      locationStream.listen((location) async {
        if (lastLocationFromLocal != null) {
          distance = await geoService.getDistance(
              LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0),
              LatLng(lastLocationFromLocal.latitude ?? 0.0,
                  lastLocationFromLocal.longitude ?? 0.0));
        }

        model.latitude = location.latitude;
        model.longitude = location.longitude;
        model.distance = distance;

        locationProvider.add(model);
      });
    }
  }
}
