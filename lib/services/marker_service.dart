import 'package:flutter_texi_tracker/model/driver_location_model.dart';
import 'package:flutter_texi_tracker/model/user_profile.dart';
import 'package:flutter_texi_tracker/services/firebase_location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MarkerService {
  Future<List<PlacemarkMapObject>> getMarkers(
      {List<UserProfile>? profiles,
      FirebaseLocationService? locationService,
      required Function(List<DriverLocationModel>) getDrivers,
      PlacemarkIcon? carBitMapDescriptor}) async {
    final markers = <PlacemarkMapObject>[];
    final drivers = <DriverLocationModel>[];

    profiles?.forEach((profile) {
      locationService?.getDriverData(did: profile.uid).listen((place) {
        PlacemarkMapObject marker = PlacemarkMapObject(
          mapId: MapObjectId('${place?.latitude}'),
          isDraggable: false,

          // infoWindow: InfoWindow(title: place?.address, snippet: place?.city),
          icon: carBitMapDescriptor!,
          point: Point(
              latitude: place?.latitude ?? 0.0,
              longitude: place?.longitude ?? 0.0),
        );
        markers.add(marker);
        drivers.add(place!);
      });
    });
    getDrivers(drivers);
    return markers;
  }
}
