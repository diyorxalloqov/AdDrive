import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:addrive/controller/driver_list_controller.dart';
import 'package:addrive/global/imports/app_imports.dart';
import 'package:addrive/global/widgets/decoration_widget.dart';
import 'package:addrive/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

class DriversScreen extends StatelessWidget {
  final controller = Get.put(DriverListController());

  DriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('drivers'.tr, style: context.theme.textTheme.labelMedium),
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: context.isDarkMode ? Colors.white : Colors.black,
              size: 20,
            )),
      ),
      body: Obx(() {
        return Stack(
          children: [
            controller.isLoading.isTrue
                ? const Center(child: Loading())
                : const SizedBox(),
            controller.driverListData.value != null
                ? ListView.builder(
                    itemCount:
                        controller.driverListData.value?.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final data =
                          controller.driverListData.value?.data?[index];
                      return Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 40),
                              decoration: decoration(context),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 80, left: 20, right: 20, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ProfileItemWidget(
                                        title: data?.name ?? "Name Not Found",
                                        icon: Assets.iconsProfile2),
                                    ProfileItemWidget(
                                        title: data?.phone ?? "N/A",
                                        icon: Assets.driverIconsBiPhone),
                                    ProfileItemWidget(
                                        title: '${data?.vehicleNumber}',
                                        icon: Assets.drawerIconVehicles),
                                    ProfileItemWidget(
                                        icon: Assets.driverIconsLocation,
                                        title: '${data?.currentAddress}'),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage('${data?.avatar}'),
                                        fit: BoxFit.cover)),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        );
      }),
    );
  }
}
