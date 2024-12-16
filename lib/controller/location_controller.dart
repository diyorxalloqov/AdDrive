import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_texi_tracker/app_config/app_config.dart';
import 'package:flutter_texi_tracker/app_config/common_method.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/data/local_data/shared_preference.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/hive/hive_location_provider.dart';
import 'package:flutter_texi_tracker/map_style/util.dart';
import 'package:flutter_texi_tracker/model/driver_location_model.dart';
import 'package:flutter_texi_tracker/model/live_data_model.dart';
import 'package:flutter_texi_tracker/screens/wrapper/location_wrapper.dart';
import 'package:flutter_texi_tracker/services/location_service.dart';
import 'package:flutter_texi_tracker/services/firebase_location_service.dart';
import 'package:flutter_texi_tracker/services/geolocator_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class LocationController extends GetxController {
  /// if driver is not true
  /// then the driver can't start
  /// can drive response come from base setting
  bool canDrive = true;

  Rx<Position?> positionStream = Rx<Position?>(null);
  Rx<geocoding.Placemark?> placeMarkStream = Rx<geocoding.Placemark?>(null);
  Rx<Marker?> marker = Rx(null);
  Rx<Marker?> startPointMarker = Rx(null);
  Rx<Circle?> circle = Rx(null);
  Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  Rx<Position?> lastKnownPosition = Rx<Position?>(null);
  Rx<Position?> position = Rx<Position?>(null);
  LatLng initialCameraPosition = const LatLng(23.256555, 90.157965);
  Rx<LocationData?> userLocation = Rx<LocationData?>(null);
  RxBool canStoreLocation = RxBool(false);
  RxDouble distance = RxDouble(0.0);
  HiveLocationProvider locationProvider = HiveLocationProvider();
  FirebaseLocationService locationService = FirebaseLocationService();
  final geoService = GeoLocatorService();
  DriverLocationModel? driverLocationModel;
  StreamSubscription? locationSubscription;
  final user = AuthController();
  Location location = Location();
  Repository repository = Get.find();
  RxBool isDriving = false.obs;
  late Rx<PermissionStatus> permissionGranted;
  Rx<LiveDataModel?> liveLocationData = Rx<LiveDataModel>(LiveDataModel(
      success: true, message: 'driving', distance: 0.0, locationData: []));

  ///this is the key object - the PolylinePoints
  ///which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();

  ///google map key from developer account
  String googleAPIKey = "AIzaSyBRIkZt9KCb2yPn-VU5Ryy6-OBc-sT2H8k";

  ///this will hold the generated polylines
  Set<Polyline> polylineSet = {};

  ///list of way
  List<PolylineWayPoint> polylineWayPoints = [];

  ///this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];

  ///when start driving api call
  ///after that it's given us trackingId
  int? trackingId;

  ///duration interval for calling barikoi api
  int durationInMin = 5;

  ///bari koi location response
  // Rx<BariKoiLocationModel?> barikoiLocation = Rx(null);
  RxString driveAddress = ''.obs;

  LocationController() {
    // repository = Get.find();
    basicSetting();
    baseSetting();
    getCurrentLocation();
    _checkPermissions();
    getDriverPositionFuture();
    getLastKnownPosition();
  }

  getDriverPositionStream() {
    geoService.getCoords().listen((value) {
      positionStream.value = value;
      updateMarkerAndCircle();
      getAddressByPosition();
      getLastKnownLocation();
    });
  }

  @override
  onInit() {
    once(positionStream, (_) async {
      if (kDebugMode) {
        print('OnInit call from once');
      }
      // await getLocationFromBariKoiApi(positionStream.value?.latitude, positionStream.value?.longitude);
    });

    interval(
      positionStream,
      (_) async {
        if (kDebugMode) {
          print('OnInit call from interval');
        }
        durationInMin = 5;

        ///bari koi api
        // await getLocationFromBariKoiApi(positionStream.value?.latitude, positionStream.value?.longitude);
      },
      time: Duration(minutes: durationInMin),
    );
    super.onInit();
  }

  ///check location permission
  Future<void> _checkPermissions() async {
    final data = await location.hasPermission();
    permissionGranted = data.obs;
  }

  addLocationDataToLocal() async {
    Timer.periodic(const Duration(minutes: 1), (timer) async {
      final trackingIdFromLocal = await getLocalData(key: 'tracking_id');
      if(trackingIdFromLocal != 'null'){
        ///checkCondition
        if (canStoreLocation.isTrue) {
          await getDriverPositionFuture();

          startListening();

          if (kDebugMode) {
            print('local lat ${positionStream.value.toString()}');
            print('local lng ${position.value.toString()}');
          }

          double distance = 0.0;

          ///last position
          DriverLocationModel? lastPosition = getLastLocationFromLocal();

          ///first position
          DriverLocationModel? firstPosition = getFirstLocationFromLocal();

          ///check last position and first position
          ///if not null the try to get distance
          distance = await geoService.getDistance(
              LatLng(firstPosition?.latitude ?? 0.0,
                  firstPosition?.longitude ?? 0.0),
              LatLng(
                  lastPosition?.latitude ?? 0.0, lastPosition?.longitude ?? 0.0));

          driverLocationModel = DriverLocationModel(
              latitude: positionStream.value?.latitude,
              longitude: positionStream.value?.longitude,
              speed: positionStream.value?.speed,
              city: placeMarkStream.value?.locality,
              country: placeMarkStream.value?.country,
              countryCode: placeMarkStream.value?.isoCountryCode,
              address:
              '${placeMarkStream.value?.name} ${placeMarkStream.value?.subLocality} ${placeMarkStream.value?.thoroughfare} ${placeMarkStream.value?.subThoroughfare}',
              heading: positionStream.value?.heading,
              distance: distance);

          ///add data to local database
          locationProvider.add(driverLocationModel!);
        }
      }
    });
  }

  ///return future location
  getDriverPositionFuture() async {
    position.value = await geoService.getCordFuture();
    position.refresh();
    // updateMarkerAndCircle();
  }

  ///calculate distance between two points
  getDistance({required LatLng origin, required LatLng destination}) async {
    distance.value = await geoService.getDistance(origin, destination);
  }

  ///return last known position
  getLastKnownPosition() async {
    lastKnownPosition.value = await geoService.getLastKnownPosition();
  }

  deleteAllDataFromLocal({required int? uid}) async {
    if (kDebugMode) {
      print('data that sending server ${locationProvider.toMapList()}');
    }
    await repository.sendStopLocationData(
        userId: uid,
        locations: locationProvider.toMapList(),
        trackingId: trackingId);
    stopListening();
    if (kDebugMode) {
      print('Deleting data from local ${locationProvider.toMapList()}');
    }
    await locationProvider.deleteAllLocation();
  }

  deleteDataAndSendToServer({required int? uid}) async {
    ///periodicTimer
    Timer.periodic(const Duration(minutes: 3), (timer) async {
      ///get recent trackingId from local
      final trackingIdFromLocal = await getLocalData(key: 'tracking_id');
      if(trackingIdFromLocal != 'null'){
        ///checkCondition
        if (canStoreLocation.isTrue) {
          ///storeDataToFirebase
          sendDataToFirebase(position: driverLocationModel!, uid: '$uid');

          if (kDebugMode) {
            print(
                'data that u have to sent server ${locationProvider.toMapList()}');
          }

          liveLocationData.value = await repository.sendStopLocationData(
              userId: uid,
              locations: locationProvider.toMapList(),
              trackingId: trackingId);

          if (liveLocationData.value?.success == true) {
            await locationProvider.deleteAllLocation();
          }

          ///updateWidgetTree
          update();
        }
      }
    });
  }

  updateUserData({map, uid}) {
    locationService.updateUserField(map: map, uid: uid);
  }

  updateUserLocationData(
      {required DriverLocationModel position, required String? uid}) {
    locationService.addLocationData(position: position, uid: uid);
  }

  ///store driver location data to firebase
  sendDataToFirebase({required DriverLocationModel position, String? uid}) {
    if (kDebugMode) {
      print('user_id $uid');
      print('lat ${position.latitude}');
      print('lng ${position.longitude}');
      print('distance ${position.distance}');
    }

    locationService.addLocationData(position: position, uid: uid);
  }

  ///return last known location
  getLastKnownLocation() async {
    Position? lastKnownPosition = await geoService.getLastKnownPosition();
    initialCameraPosition = LatLng(lastKnownPosition?.latitude ?? 0.0,
        lastKnownPosition?.longitude ?? 0.0);
  }

  ///return last stored location from hive database
  getLastLocationFromLocal() {
    return locationProvider.getUserLastPosition();
  }

  ///return first stored location from hive database
  getFirstLocationFromLocal() {
    return locationProvider.getUserFirstPosition();
  }

  ///start listening driver location
  startListening() {
    canStoreLocation.value = true;
    onDrivingModeCameraPosition();
    update();
  }

  ///stop listening driver location
  stopListening() {
    canStoreLocation.value = false;
    onStopModeCameraPosition();
    update();
  }

  ///update marker and circle on map
  ///based on driver location
  updateMarkerAndCircle() async {
    final icon = await Common.setCustomMapPin('asset/car_icon/car_white.png');
    final originLat = await getLocalData(key: 'last_lat');
    final originLng = await getLocalData(key: 'last_lng');
    final origin = LatLng(
        double.parse(originLat ?? '0.0'), double.parse(originLng ?? '0.0'));

    marker.value = Marker(
        markerId: const MarkerId('current'),
        position: LatLng(userLocation.value?.latitude ?? 0.0,
            userLocation.value?.longitude ?? 0.0),
        icon: icon,
        flat: true,
        zIndex: 2,
        draggable: false,
        anchor: const Offset(0.5, 0.5),
        rotation: userLocation.value?.heading ?? 0.0,
        infoWindow: const InfoWindow(title: 'Current position'));

    startPointMarker.value = Marker(
        markerId: const MarkerId('origin'),
        position: origin,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        flat: true,
        visible: isDriving.isTrue,
        zIndex: 2,
        draggable: false,
        infoWindow: const InfoWindow(title: 'start position'));

    circle.value = Circle(
      circleId: const CircleId('car'),
      radius: userLocation.value?.accuracy ?? 0.0,
      zIndex: 1,
      strokeColor: CustomColors().mainColor(0.1),
      center: LatLng(userLocation.value?.latitude ?? 0.0,
          userLocation.value?.longitude ?? 0.0),
    );
  }

  ///return driver current location stream
  ///for this we use another package called {Location:any}
  ///to get location more better way
  void getCurrentLocation() {
    // if (locationServiceProvider == null)
    locationServiceProvider = LocationService();

    ///listening data from location service
    locationSubscription =
        locationServiceProvider.locationStream.listen((event) async {
      ///initialize userLocation data
      userLocation.value = event;

      ///convert locationData into Position data
      positionStream.value = Position(
          latitude: event.latitude ?? 0.0,
          longitude: event.longitude ?? 0.0,
          speed: event.speed ?? 0.0,
          heading: event.heading ?? 0.0,
          altitude: event.altitude ?? 0.0,
          accuracy: event.accuracy ?? 0.0,
          timestamp: DateTime.now(),
          speedAccuracy: event.speedAccuracy ?? 0.0,
          altitudeAccuracy: event.altitude ?? 0.0,
          headingAccuracy: event.accuracy ?? 0.0);

      ///getting address from current position
      getAddressByPosition();

      ///initial camera position
      initialCameraPosition =
          LatLng(event.latitude ?? 0.0, event.longitude ?? 0.0);

      ///update initial position and move camera position to
      ///center and it will call every time when we listen location
      ///from gps and driver is driving
      if (mapController.value != null) {
        mapController.value?.moveCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(positionStream.value?.latitude ?? 0.0,
                    positionStream.value?.longitude ?? 0.0),
                zoom: 16.0)));
      }

      ///updating marker and circle
      updateMarkerAndCircle();

      update();
    });
  }

  ///onMapCreated to initialize map controller
  onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
    mapController.value?.setMapStyle(Utils.mapStyles);
    getLastKnownLocation();
  }

  ///dispose location subscription
  @override
  void onClose() {
    locationSubscription?.cancel();
    super.onClose();
  }

  onDrivingModeCameraPosition() {
    mapController.value!
        .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(userLocation.value?.latitude ?? 0.0,
          userLocation.value?.longitude ?? 0.0),
      zoom: 16.0,
    )));
  }

  onStopModeCameraPosition() {
    mapController.value!.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(userLocation.value?.latitude ?? 0.0,
                userLocation.value?.longitude ?? 0.0),
            zoom: 16.0)));
  }

  getAddressByPosition() async {
    final places = await geoService.getAddress(positionStream.value!);
    placeMarkStream.value = places?.elementAt(0);
    getDriverAddress();
    placeMarkStream.refresh();
  }

  ///when user start driving
  ///tracking id must be null
  getDriverStartMoving(userId) async {
    ///get recent trackingId from local
    final trackingIdFromLocal = await getLocalData(key: 'tracking_id');
    if(trackingIdFromLocal == 'null'){
      await locationProvider.deleteAllLocation();
    }
    ///requestData
    final data = {"is_stop": 0, "driver_id": userId, "tracking_id": null};

    ///serverRequest
    final response = await repository.moveDriverLocationData(data);

    ///trackingId
    trackingId = response['tracking_id'];

    ///store recent trackingId to local
    storeLocalData(key: 'tracking_id', value: '$trackingId');

    ///toast
    Fluttertoast.showToast(msg: '${response['message']}');

    ///updateMarker
    updateMarkerAndCircle();

    ///storeLastKnownLocationToLocal
    storeLocalData(key: 'last_lat', value: '${positionStream.value!.latitude}');
    storeLocalData(key: 'last_lng', value: '${positionStream.value!.longitude}');

    ///if response success false
    ///firebase driving status will
    ///be 0 (stop state)
    if (!response['success']) {
      updateDataFirebase();
    }
  }

  ///when user stop driving
  getDriverStopMoving(userId) async {
    ///get recent trackingId from local
    final trackingIdFromLocal = await getLocalData(key: 'tracking_id');

    ///post data map
    final data = {
      "is_stop": 1,
      "driver_id": userId,
      "tracking_id": trackingId ?? trackingIdFromLocal
    };

    ///server api call
    final response = await repository.moveDriverLocationData(data);

    ///store tracking id from response
    ///if driver has no sticker then tracking id will be null
    if (trackingId != null) {
      trackingId = response['tracking_id'] ?? int.parse(trackingIdFromLocal!);
    }

    ///updating driver last location
    ///when he ended his driving
    deleteDataAndSendToServer(uid: userId);

    ///clean polyline from set
    polylineSet.clear();

    ///clean way point list from list
    polylineWayPoints.clear();

    ///showing success message
    Fluttertoast.showToast(msg: '${response['message']}');

    ///store recent trackingId to local
    storeLocalData(key: 'tracking_id', value: 'null');

    ///updateMarkerAndCircle
    updateMarkerAndCircle();
  }

  ///set realtime polyline on map(when driving)
  ///it will draw route based on driver position
  setPolyline(LatLng source, LatLng destination) async {
    if (kDebugMode) {
      print('source ${source.toString()}');
      print('destination ${destination.toString()}');
    }

    PolylineResult? result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        wayPoints: polylineWayPoints,
        optimizeWaypoints: true);

    for (var point in result.points) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    // create a Polyline instance
    // with an id, an RGB color and the list of LatLng pairs
    Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        color: Colors.red,
        width: 4,
        points: polylineCoordinates);

    // add the constructed polyline as a set of points
    // to the polyline set, which will eventually
    // end up showing up on the map
    polylineSet.add(polyline);
  }

  updateDataFirebase() {
    final map = {
      'is_driving': 0,
      'last_login': Timestamp.now().seconds,
      'uid': '${user.getUser()?.id}'
    };
    updateUserData(map: map, uid: user.getUser()?.id);
  }

  Future baseSetting() async {
    final response = await repository.baseSettings();
    canDrive = response?.data?.canDrive ?? true;
    update();
  }

  /// basic settings for currency and upcoming conditions
  Future basicSetting() async {
    final response = await repository.basicSettings();
    setValue('currency', response?.data?.value);
    update();
  }

  getDriverAddress() {
    driveAddress.value =
        '${placeMarkStream.value?.name ?? ''} ${placeMarkStream.value?.administrativeArea ?? ''}';
    update();
  }
}
