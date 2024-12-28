import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/model/daily_tracking_model.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../screens/google_map_polynie/google_map_poly_line.dart';

class PolylineController extends GetxController {
  final Repository _repository = Get.find();
  AuthController authController = Get.find();
  CameraPosition? initialLocation;
  Rx<DailyTrackingDetails?> dailyTackingDetails = Rx(null);
  RxList<DailyTrackingList> latLongData = <DailyTrackingList>[].obs;
  final trackingId = Get.arguments;
  RxBool isLoading = false.obs;

  PolylineController() {
    getLatLongData();
  }

  Future getLatLongData() async {
    debugPrint('daily_tracking_id $trackingId');
    final driverId = authController.getUser()?.id;
    final data = {"driver_id": driverId, "daily_tracking_id": trackingId};

    isLoading.value = !isLoading.value;
    final response = await _repository.drivingDailyTracking(data);
    dailyTackingDetails.value = response;
    if (response != null) {
      latLongData.value = response.data!;
    }
    if (latLongData.isNotEmpty) {
      initialLocation = CameraPosition(
        zoom: cameraZoom,
        azimuth: cameraBearing,
        tilt: cameraTilt,
        target: Point(
            latitude: latLongData.first.latitude ?? 0.0,
            longitude: latLongData.first.longitude ?? 0.0),
      );
    }

    isLoading.value = !isLoading.value;
  }
}
