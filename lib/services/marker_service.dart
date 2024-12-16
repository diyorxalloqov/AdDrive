import 'package:flutter_texi_tracker/model/driver_location_model.dart';
import 'package:flutter_texi_tracker/model/user_profile.dart';
import 'package:flutter_texi_tracker/services/firebase_location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {
  Future<List<Marker>> getMarkers({
      List<UserProfile>? profiles,
      FirebaseLocationService? locationService,
      required Function(List<DriverLocationModel>) getDrivers,
      BitmapDescriptor? carBitMapDescriptor}) async {
    final markers = <Marker>[];
    final drivers = <DriverLocationModel>[];

    profiles?.forEach((profile) {
      locationService?.getDriverData(did: profile.uid).listen((place) {
        Marker marker = Marker(
          markerId: MarkerId('${place?.latitude}'),
          draggable: false,
          infoWindow: InfoWindow(title: place?.address, snippet: place?.city),
          icon: carBitMapDescriptor!,
          position: LatLng(place?.latitude ?? 0.0, place?.longitude ?? 0.0),
        );
        markers.add(marker);
        drivers.add(place!);
      });
    });
    getDrivers(drivers);
    return markers;
  }
}
