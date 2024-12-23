import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/controller/driver_profile_controller.dart';
import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:flutter_texi_tracker/global/widgets/decoration_widget.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(DriverProfileController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
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
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 60),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  decoration: decoration(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SpaceHeight(height: 80),
                                      ProfileItemWidget(
                                          title: controller.driverProfile.value
                                                  ?.data?.name ??
                                              "Name Not Found",
                                          icon: Assets.iconsProfile2),
                                      ProfileItemWidget(
                                          title: controller.driverProfile.value
                                                  ?.data?.phone ??
                                              "No Phone Number Found",
                                          icon: Assets.driverIconsBiPhone),
                                      ProfileItemWidget(
                                          title: controller
                                                  .driverProfile
                                                  .value
                                                  ?.data
                                                  ?.driver
                                                  ?.currentAddress ??
                                              'N/A',
                                          icon: Assets.iconsCilLocationPin),
                                      ProfileItemWidget(
                                          title: controller.driverProfile.value
                                                  ?.data?.vehicleNumber ??
                                              "No Vehicle Number Found",
                                          icon: Assets.drawerIconVehicles),
                                    ],
                                  ),
                                ),

                                ///take image from here.............
                                Positioned(
                                  top: 0,
                                  child: TextButton(
                                    onPressed: () {
                                      Get.dialog(
                                        AlertDialog(
                                          title:
                                              const Text('Select Image from'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      controller
                                                          .imgFromCamera();
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
                                                      controller
                                                          .imgFromGallery();
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
                                          decoration: ShapeDecoration(
                                            shape: const OvalBorder(),
                                            color: context.isDarkMode
                                                ? CustomColors().greyColor(1)
                                                : Colors.white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${controller.avatarRX}'),
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
                                              child: const Icon(Icons.edit,
                                                  color: Colors.white,
                                                  size: 12),
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
                                              controller
                                                      .driverProfile
                                                      .value
                                                      ?.data
                                                      ?.agreement
                                                      ?.startDate
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
                                              controller.driverProfile.value
                                                      ?.data?.agreement?.endDate
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
                          const SizedBox(height: 200),
                        ],
                      ),
                    )
                  : const SizedBox()
            ],
          );
        }),
      ),
    );
  }
}

class ProfileItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  const ProfileItemWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        dense: true,
        title: Text(title, style: context.theme.textTheme.headlineSmall),
        leading: SizedBox(width: 20, height: 20, child: SvgPicture.asset(icon)),
        minLeadingWidth: 10,
        contentPadding: EdgeInsets.zero);
  }
}
