import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/controller/location_controller.dart';
import 'package:flutter_texi_tracker/model/hive_model/user_model.dart';
import 'package:flutter_texi_tracker/model/user_profile.dart';
import 'package:flutter_texi_tracker/controller/owner_profile_controller.dart';
import 'package:flutter_texi_tracker/services/firebase_location_service.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lotte;
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  DriverHomeScreenState createState() => DriverHomeScreenState();
}

class DriverHomeScreenState extends State<DriverHomeScreen> {
  final historyController = Get.find<OwnerProfileController>();
  BitmapDescriptor? carIcon;
  // final locationService = LocationService();

  @override
  void initState() {
    super.initState();

    /// Calling the necessary methods after a 3-second delay
    Future.delayed(const Duration(seconds: 3), () async {
      LocationController controller = Get.find<LocationController>();
      AuthController authController = Get.find<AuthController>();
      User user = authController.getUser()!;

      controller.startListening();

      controller.addLocationDataToLocal();

      controller.deleteDataAndSendToServer(uid: user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseLocationService =
        Provider.of<FirebaseLocationService>(context);
    AuthController authController = Get.find<AuthController>();

    return Scaffold(
        body: _buildList(firebaseLocationService, authController.getUser()!));
  }

  Widget _buildList(FirebaseLocationService service, User user) {
    return StreamBuilder<DriverProfile>(
      stream: service.getUserProfile(user.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ///isDriving == 0 => false (not driving)
          ///isDriving == 1 => true (he is driving)
          bool isDriving = snapshot.data?.isDriving == 1 ? true : false;

          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              GetBuilder<LocationController>(
                init: LocationController(),
                initState: (_) => LocationController(),
                builder: (controller) {
                  controller.isDriving.value = isDriving;
                  //
                  // print('isDriving : ${controller.isDriving.value}');
                  // print('trackingId : ${controller.trackingId}');
                  //
                  // if(controller.isDriving.isTrue && controller.trackingId == null){
                  //   controller.canStoreLocation.value  = true;
                  //   controller.addLocationDataToLocal();
                  //   controller.deleteDataAndSendToServer(uid: user.id);
                  // }

                  return GoogleMap(
                    onMapCreated: controller.onMapCreated,
                    initialCameraPosition: CameraPosition(
                        target: controller.initialCameraPosition, zoom: 16.0),
                    mapType: MapType.terrain,
                    myLocationEnabled: false,
                    indoorViewEnabled: true,
                    padding:
                        EdgeInsets.only(bottom: ScreenUtil().screenHeight / 3),
                    onTap: (place) {
                      if (isDriving) {
                        controller.onDrivingModeCameraPosition();
                      } else {
                        controller.onStopModeCameraPosition();
                      }
                    },
                    markers: controller.marker.value != null
                        ? {
                            controller.marker.value!,
                            controller.startPointMarker.value!
                          }
                        : {},
                    circles: controller.circle.value != null
                        ? {controller.circle.value!}
                        : {},
                    polylines: controller.polylineSet,
                  );
                },
              ),
              Positioned(
                bottom: 30,
                left: 10,
                right: 10,
                child: GetBuilder<LocationController>(
                    initState: (_) => LocationController(),
                    builder: (controller) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2.0, 2.0),
                                blurRadius: 8,
                              )
                            ],
                            color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('distance'.tr,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                          height: 2,
                                          fontWeight: FontWeight.w600)),
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    spacing: 6,
                                    children: [
                                      Text(
                                          '${controller.liveLocationData.value != null ? controller.liveLocationData.value?.distance : ''}',
                                          style: const TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black)),
                                      const Text(
                                        'km',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      if (isDriving)
                                        Image.asset(
                                          'asset/icons/markers/car_icon_animated.gif',
                                          scale: 2,
                                        ),
                                    ],
                                  ),
                                  Text(
                                    // '${controller.placeMarkStream.value?.name ?? ''} ${controller.placeMarkStream.value?.subLocality ?? ''}',
                                    '${controller.driveAddress}',
                                    style: const TextStyle(
                                        fontSize: 11.0,
                                        color: Colors.grey,
                                        height: 1.4,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                    title: isDriving
                                        ? 'stop_driving'.tr
                                        : 'start_driving'.tr,
                                    barrierDismissible: false,
                                    confirmTextColor: Colors.white,
                                    content: Column(
                                      children: [
                                        lotte.Lottie.asset(
                                          'asset/lotte/car_lotte.json',
                                        ),
                                        Text(
                                          '${'are_you_sure_that_you_want_to'.tr} ${isDriving ? 'stop_driving'.tr : 'start_driving'.tr}?',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    textConfirm: 'yes'.tr,
                                    textCancel: 'no'.tr,
                                    onConfirm: () async {
                                      Get.back();

                                      if (isDriving) {
                                        ///get driving stop moving
                                        controller.getDriverStopMoving(user.id);

                                        ///when driver stop driving
                                        ///we have update driving
                                        ///history data
                                        await historyController
                                            .getDrivingHistory();
                                      } else {
                                        controller
                                            .getDriverStartMoving(user.id);
                                      }

                                      final map = {
                                        'is_driving': isDriving ? 0 : 1,
                                        'last_login': Timestamp.now().seconds,
                                        'uid': '${user.id}'
                                      };

                                      controller.updateUserData(
                                          map: map, uid: user.id);
                                    },
                                    onCancel: () {
                                      Get.back();
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(28.0),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 8,
                                      )
                                    ]),
                                child: Text(
                                  isDriving ? 'stop'.tr : 'start'.tr,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<LocationController>(
                    builder: (controller) {
                      return IconButton(
                          onPressed: () {
                            if (isDriving) {
                              controller.onDrivingModeCameraPosition();
                            } else {
                              controller.onStopModeCameraPosition();
                            }
                          },
                          icon: const Icon(Icons.location_searching_outlined));
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
