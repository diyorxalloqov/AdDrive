import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/controller/location_controller.dart';
import 'package:flutter_texi_tracker/generated/assets.dart';
import 'package:flutter_texi_tracker/model/hive_model/user_model.dart';
import 'package:flutter_texi_tracker/controller/owner_profile_controller.dart';
import 'package:flutter_texi_tracker/screens/main_screen/cubit/location_cubit.dart';
import 'package:flutter_texi_tracker/utils/enums/status.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DriverHomeScreen extends StatelessWidget {
  final OwnerProfileController historyController;
  final bool isDriving;
  final User user;
  final LocationState state;
  const DriverHomeScreen(
      {super.key,
      required this.isDriving,
      required this.state,
      required this.user,
      required this.historyController});

  @override
  Widget build(BuildContext context) {
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

            return Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().screenHeight / 3),
              child: YandexMap(
                onMapCreated: controller.onMapCreated,
                zoomGesturesEnabled: true,
                // initialCameraPosition: CameraPosition(
                //     target: controller.initialCameraPosition, zoom: 16.0),
                mapType: MapType.hybrid,
                // myLocationEnabled: false,
                // indoorViewEnabled: true,
                fastTapEnabled: true,
                mode2DEnabled: true,
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,

                onMapTap: (place) {
                  if (isDriving) {
                    controller.onDrivingModeCameraPosition();
                  } else {
                    controller.onStopModeCameraPosition();
                  }
                },

                // markers: controller.marker.value != null
                //     ? {
                //         controller.marker.value!,
                //         controller.startPointMarker.value!
                //       }
                //     : {},
                // circles: controller.circle.value != null
                //     ? {controller.circle.value!}
                //     : {},
                //
                // polylines: controller.polylineSet,
              ),
            );
          },
        ),
        state.locationStatus == ActionStatus.isSuccess
            ? const SizedBox.shrink()
            : Positioned(child: Container(color: Colors.black26)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 190),
          child: Align(
            alignment: Alignment.bottomRight,
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
                    icon: SvgPicture.asset(Assets.iconsLocation));
              },
            ),
          ),
        ),
      ],
    );
  }
}
