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
                  ? const Center(child: Loading())
                  : const SizedBox(),
              controller.driverProfile.value != null
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          const SpaceHeight(height: 20),
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
                                          backgroundColor:
                                              context.theme.colorScheme.primary,
                                          title: Text('select_image'.tr),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      controller
                                                          .imgFromCamera();
                                                      Get.back();
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SvgPicture.asset(
                                                          Assets.iconsCameraAdd,
                                                          width: 30,
                                                          color: CustomColors()
                                                              .greyColor(0.5),
                                                        ),
                                                        const SpaceHeight(
                                                            height: 10),
                                                        Text('camera'.tr,
                                                            style: context
                                                                .theme
                                                                .textTheme
                                                                .headlineSmall)
                                                      ],
                                                    )),
                                                GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      controller
                                                          .imgFromGallery();
                                                      Get.back();
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SvgPicture.asset(
                                                          Assets.iconsGallery,
                                                          width: 30,
                                                          color: CustomColors()
                                                              .greyColor(0.5),
                                                        ),
                                                        const SpaceHeight(
                                                            height: 10),
                                                        Text('gallery'.tr,
                                                            style: context
                                                                .theme
                                                                .textTheme
                                                                .headlineSmall)
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
                                          height: 90,
                                          width: 90,
                                          decoration: ShapeDecoration(
                                            shape: const OvalBorder(),
                                            color: context
                                                .theme.colorScheme.onPrimary,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${controller.avatarRX}'),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 6,
                                          right: 2,
                                          child: Container(
                                            padding: const EdgeInsets.all(2.0),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black38),
                                                child: const Icon(Icons.edit,
                                                    size: 12)),
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
                            child: Container(
                              decoration: decoration(context),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('driver_information'.tr,
                                        style: context
                                            .theme.textTheme.labelMedium),
                                    const SpaceHeight(height: 12),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 100,
                                            child: Text('license_no'.tr,
                                                style: context
                                                    .theme.textTheme.bodySmall
                                                    ?.copyWith(fontSize: 14))),
                                        Expanded(
                                          child: Text(
                                              ': ${controller.driverProfile.value?.data?.driver?.drivingLicenceNumber ?? 'N/A'}',
                                              style: context
                                                  .theme.textTheme.bodySmall
                                                  ?.copyWith(fontSize: 14)),
                                        )
                                      ],
                                    ),
                                    const SpaceHeight(height: 10),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 100,
                                            child: Text('expired_date'.tr,
                                                style: context
                                                    .theme.textTheme.bodySmall
                                                    ?.copyWith(fontSize: 14))),
                                        Expanded(
                                          child: Text(
                                              ': ${controller.driverProfile.value?.data?.driver?.drivingLicenceExpiryDate ?? 'N/A'}',
                                              style: context
                                                  .theme.textTheme.bodySmall
                                                  ?.copyWith(fontSize: 14)),
                                        )
                                      ],
                                    ),
                                    const SpaceHeight(height: 10),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 100,
                                            child: Text('NID_no'.tr,
                                                style: context
                                                    .theme.textTheme.bodySmall
                                                    ?.copyWith(fontSize: 14))),
                                        Expanded(
                                          child: Text(
                                              ': ${controller.driverProfile.value?.data?.driver?.nidCard ?? 'N/A'}',
                                              style: context
                                                  .theme.textTheme.bodySmall
                                                  ?.copyWith(fontSize: 14)),
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
                            child: Container(
                              decoration: decoration(context),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('agreement_information'.tr,
                                        style: context
                                            .theme.textTheme.labelMedium),
                                    const SpaceHeight(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('DISTANCE'.tr,
                                                style: context
                                                    .theme.textTheme.bodySmall),
                                            Wrap(spacing: 4, children: [
                                              Text(
                                                  '${controller.driverProfile.value?.data?.agreement?.distance ?? '0'}',
                                                  style: context.theme.textTheme
                                                      .labelMedium
                                                      ?.copyWith(fontSize: 14)),
                                              Text('km'.tr,
                                                  style: context.theme.textTheme
                                                      .labelMedium
                                                      ?.copyWith(fontSize: 14))
                                            ]),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('total_car'.tr,
                                                style: context
                                                    .theme.textTheme.bodySmall),
                                            Wrap(spacing: 4, children: [
                                              Text(
                                                  '${controller.driverProfile.value?.data?.agreement?.totalCar ?? '0'}',
                                                  style: context.theme.textTheme
                                                      .labelMedium
                                                      ?.copyWith(fontSize: 14)),
                                              Text('car'.tr,
                                                  style: context.theme.textTheme
                                                      .labelMedium
                                                      ?.copyWith(fontSize: 14))
                                            ]),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text('amount'.tr,
                                                style: context
                                                    .theme.textTheme.bodySmall),
                                            const SpaceHeight(height: 4),
                                            Wrap(spacing: 4, children: [
                                              Text(
                                                  '${controller.driverProfile.value?.data?.agreement?.amount ?? '0'}',
                                                  style: context.theme.textTheme
                                                      .labelMedium
                                                      ?.copyWith(fontSize: 14)),
                                              Text(controller.currency ?? '',
                                                  style: context.theme.textTheme
                                                      .labelMedium
                                                      ?.copyWith(fontSize: 14))
                                            ]),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SpaceHeight(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('start_date'.tr,
                                                style: context
                                                    .theme.textTheme.bodySmall),
                                            const SpaceHeight(height: 4),
                                            Text(
                                                controller
                                                        .driverProfile
                                                        .value
                                                        ?.data
                                                        ?.agreement
                                                        ?.startDate
                                                        .toString() ??
                                                    'N/A',
                                                style: context
                                                    .theme.textTheme.labelMedium
                                                    ?.copyWith(fontSize: 14)),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text('end_date'.tr,
                                                style: context
                                                    .theme.textTheme.bodySmall),
                                            const SpaceHeight(height: 4),
                                            Text(
                                                controller
                                                        .driverProfile
                                                        .value
                                                        ?.data
                                                        ?.agreement
                                                        ?.endDate
                                                        .toString() ??
                                                    'N/A',
                                                style: context
                                                    .theme.textTheme.labelMedium
                                                    ?.copyWith(fontSize: 14)),
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
