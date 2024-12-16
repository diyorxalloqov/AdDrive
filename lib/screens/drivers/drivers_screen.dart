import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/controller/driver_list_controller.dart';
import 'package:get/get.dart';

class DriversScreen extends StatelessWidget {
  final controller = Get.put(DriverListController());

   DriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('drivers'.tr, style: const TextStyle(color: Colors.white, fontSize: 16),),
        leading: InkWell(
            onTap: ()=> Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20,)),
      ),
      body: Obx(() {
        return Stack(
          children: [
            controller.isLoading.isTrue
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
            controller.driverListData.value != null
                ? ListView.builder(
                    itemCount: controller.driverListData.value?.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final data = controller.driverListData.value?.data?[index];
                      return Container(
                        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 40),
                              child: Card(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 80, left: 20, right: 20, bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(data?.name ?? "Name Not Found", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                                      const SizedBox(
                                        height: 17,
                                      ),
                                      ListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        dense: true,
                                        title: Text(
                                          data?.phone ?? "N/A",

                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF555555),
                                          ),
                                        ),
                                        leading:  SizedBox(
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
                                          '${data?.vehicleNumber}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF555555),
                                          ),
                                        ),
                                        leading: SizedBox(width: 20, height: 20,
                                          child: SvgPicture.asset('asset/icons/drawer_icon/vehicles.svg',),
                                        ),
                                        minLeadingWidth: 10,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      ListTile(
                                        visualDensity: const VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        dense: true,
                                        title: Text(
                                          '${data?.currentAddress}',
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
                                            'asset/icons/driver_icons/cil_location-pin.svg',
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
                            Positioned(
                              top: 0,
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
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
