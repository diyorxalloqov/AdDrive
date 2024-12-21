import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/screens/auth/sign_in.dart';
import 'package:flutter_texi_tracker/screens/main_screen/ui/main_screen.dart';
import 'package:get/get.dart';

// LocationService locationServiceProvider = LocationService();

class LocationWrapper extends StatefulWidget {
  const LocationWrapper({super.key});

  @override
  LocationWrapperState createState() => LocationWrapperState();
}

class LocationWrapperState
    extends State<LocationWrapper> /*with AfterLayoutMixin<LocationWrapper>*/ {
  ///location instance
  // final Location location = Location();
  // final locationController = Get.put(LocationController());
  // final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return authController.getUser() != null
          ? const MainScreen()
          : const UserSignIn();
    });
  }

  // @override
  // void afterFirstLayout(BuildContext context) {
  //   ///check permission
  //   location.hasPermission().then((permissionGrantedResult) {
  //     if (permissionGrantedResult != PermissionStatus.granted) {
  //       ///pop-up
  //       _neverSatisfied();
  //     }
  //   });
  // }

  // Future<void> _neverSatisfied() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('location_permission'.tr),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('req_location'.tr,
  //                   style: const TextStyle(color: Colors.black)),
  //               Text(prominentDisclosure,
  //                   style: const TextStyle(color: Colors.black54)),
  //               const SizedBox(height: 36.0),
  //               Text(denyMessage)
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           MaterialButton(
  //             child: Text('deny'.tr),
  //             onPressed: () {
  //               Get.back();
  //             },
  //           ),
  //           MaterialButton(
  //             child: Text('allow'.tr),
  //             onPressed: () async {
  //               ///request  permission
  //               await location.requestPermission();
  //
  //               ///instantiate locationService
  //               locationServiceProvider = LocationService();
  //
  //               ///getCurrentLocation - Method called
  //               locationController.getCurrentLocation();
  //
  //               ///close dialog
  //               Get.back();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // String denyMessage = 'deny_location'.tr;
  // String prominentDisclosure = 'location_des'.tr;
}
