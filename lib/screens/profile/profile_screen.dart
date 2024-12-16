import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/controller/driver_profile_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final bool isAppBarVisible;
  final controller = Get.put(DriverProfileController());

  ProfileScreen({super.key, this.isAppBarVisible = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAppBarVisible
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: Text(
                'profile'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            )
          : null,
      body: Obx(() {
        return Stack(
          children: [
            controller.isLoading.isTrue
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
            controller.driverProfile.value != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 80,
                                        left: 16,
                                        right: 16,
                                        bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          controller.driverProfile.value?.data
                                                  ?.name ??
                                              "Name Not Found",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 17,
                                        ),
                                        ListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          dense: true,
                                          title: Text(
                                            controller.driverProfile.value?.data
                                                    ?.phone ??
                                                "No Phone Number Found",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF555555),
                                            ),
                                          ),
                                          leading: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: SvgPicture.asset(
                                              'asset/icons/driver_icons/bi_phone.svg',
                                            ),
                                          ),
                                          minLeadingWidth: 10,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        ListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          dense: true,
                                          title: Text(
                                            controller.driverProfile.value?.data
                                                    ?.vehicleNumber ??
                                                "No Vehicle Number Found",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF555555),
                                            ),
                                          ),
                                          leading: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: SvgPicture.asset(
                                              'asset/icons/drawer_icon/vehicles.svg',
                                            ),
                                          ),
                                          minLeadingWidth: 10,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        ListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          dense: true,
                                          title: Text(
                                            controller.driverProfile.value?.data
                                                    ?.driver?.currentAddress ??
                                                'N/A',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF555555),
                                            ),
                                          ),
                                          leading: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: SvgPicture.asset(
                                              'asset/icons/cil_location-pin.svg',
                                            ),
                                          ),
                                          minLeadingWidth: 10,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              ///take image from here.............
                              Positioned(
                                top: 0,
                                child: TextButton(
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        title: const Text('Select Image from'),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    controller.imgFromCamera();
                                                    Get.back();
                                                  },
                                                  child: const Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.camera,
                                                        // color: kAppPrimaryColor,
                                                      ),
                                                      Text('Camera')
                                                    ],
                                                  )),
                                              InkWell(
                                                  onTap: () {
                                                    controller.imgFromGallery();
                                                    Get.back();
                                                  },
                                                  child: const Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.image,
                                                        // color: kAppPrimaryColor,
                                                      ),
                                                      Text('Gallery')
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                '${controller.avatarRX}',
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        right: 2,
                                        child: Container(
                                          padding: const EdgeInsets.all(2.0),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        ///Driver Information
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'driver_information'.tr,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                        color: Color(0xFF999999)),
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            'license_no'.tr,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                height: 1.1,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF555555)),
                                          )),
                                      Expanded(
                                        child: Text(
                                          ': ${controller.driverProfile.value?.data?.driver?.drivingLicenceNumber ?? 'N/A'}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              height: 1.1,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.5,
                                              color: Color(0xFF555555)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            'expired_date'.tr,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                height: 1.1,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF555555)),
                                          )),
                                      Expanded(
                                        child: Text(
                                          ': ${controller.driverProfile.value?.data?.driver?.drivingLicenceExpiryDate ?? 'N/A'}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              height: 1.1,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.5,
                                              color: Color(0xFF555555)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            'NID_no'.tr,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                height: 1.1,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF555555)),
                                          )),
                                      Expanded(
                                        child: Text(
                                          ': ${controller.driverProfile.value?.data?.driver?.nidCard ?? 'N/A'}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              height: 1.1,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.5,
                                              color: Color(0xFF555555)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        ///Agreement Information
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'agreement_information'.tr,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                        color: Color(0xFF999999)),
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'DISTANCE'.tr,
                                            style: const TextStyle(
                                                fontSize: 11,
                                                height: 1.6,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF999999)),
                                          ),
                                          Wrap(spacing: 4, children: [
                                            Text(
                                              '${controller.driverProfile.value?.data?.agreement?.distance ?? '0'}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1.1,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5,
                                                  color: Color(0xFF222222)),
                                            ),
                                            Text(
                                              'km'.tr,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5,
                                                  color: Color(0xFF555555)),
                                            )
                                          ]),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'total_car'.tr,
                                            style: const TextStyle(
                                                fontSize: 11,
                                                height: 1.6,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF999999)),
                                          ),
                                          Wrap(spacing: 4, children: [
                                            Text(
                                              '${controller.driverProfile.value?.data?.agreement?.totalCar ?? '0'}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1.1,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5,
                                                  color: Color(0xFF222222)),
                                            ),
                                            Text(
                                              'car'.tr,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5,
                                                  color: Color(0xFF555555)),
                                            )
                                          ]),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'amount'.tr,
                                            style: const TextStyle(
                                                fontSize: 11,
                                                height: 1.6,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF999999)),
                                          ),
                                          Wrap(spacing: 4, children: [
                                            Text(
                                              '${controller.driverProfile.value?.data?.agreement?.amount ?? '0'}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1.1,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5,
                                                  color: Color(0xFF222222)),
                                            ),
                                            Text(
                                              controller.currency ?? '',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5,
                                                  color: Color(0xFF555555)),
                                            )
                                          ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'start_date'.tr,
                                            style: const TextStyle(
                                                fontSize: 11,
                                                height: 1.6,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF999999)),
                                          ),
                                          Text(
                                            controller.driverProfile.value?.data
                                                    ?.agreement?.startDate
                                                    .toString() ??
                                                'N/A',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                height: 1.1,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF222222)),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'end_date'.tr,
                                            style: const TextStyle(
                                                fontSize: 11,
                                                height: 1.6,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF999999)),
                                          ),
                                          Text(
                                            controller.driverProfile.value?.data
                                                    ?.agreement?.endDate
                                                    .toString() ??
                                                'N/A',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                height: 1.1,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.5,
                                                color: Color(0xFF222222)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        );
      }),
    );
  }
}
