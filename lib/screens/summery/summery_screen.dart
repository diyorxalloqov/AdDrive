import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_texi_tracker/controller/summery_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SummeryScreen extends StatelessWidget {
  final summeryList = {};

   SummeryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SummeryController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black, size: 25.0),
        title: Text(
          'summery'.tr,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        return Stack(
          children: [
            controller.isLoading.isTrue
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
            controller.driverSummeryData?.value != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(12),
                            height: Get.size.height / 3,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                            child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                series: <LineSeries<SalesData, String>>[
                                  LineSeries<SalesData, String>(
                                    dataSource: controller.summeryList,
                                    xValueMapper: (SalesData sales, _) => sales.year,
                                    yValueMapper: (SalesData sales, _) => double.parse(sales.sales),
                                  )
                                ])),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('asset/icons/drawer_icon/vehicles.svg', height: 23, width: 30, color: Colors.red,),
                                      Text('car'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.6),),
                                      Text('${controller.driverSummeryData?.value?.totalCar}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 1.3),),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('asset/icons/distance-summery.svg', height: 23, width: 30, color: Colors.red,),
                                      Text('distance'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.6),),
                                      Text('${controller.driverSummeryData?.value?.totalDistance}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 1.3),),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: Container(padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('asset/icons/earn2.svg', height: 23, width: 30, color: Colors.red,),
                                      Text('earn'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.6),),
                                      Text('${controller.driverSummeryData?.value?.amount} ${controller.currency ?? ''}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 1.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: controller.driverSummeryData?.value?.summary?.isNotEmpty == true ?  true : false,
                          child: Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('summery'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 1),),
                                const SizedBox(height: 6,),
                                const Divider(),
                                if(controller.driverSummeryData != null)
                                Column(
                                  children: controller.driverSummeryData!.value!.summary!.map(
                                        (e) => Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${e.month}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.16),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Wrap(
                                                          spacing: 8,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'asset/icons/point-arrow.svg',
                                                              height: 22,
                                                              width: 22,
                                                            ),
                                                            Text(
                                                              '${e.distance} KM',
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  height: 1.16),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Wrap(
                                                          spacing: 8,
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'asset/icons/point-arrow-mark.svg',
                                                              height: 22,
                                                              width: 22,
                                                            ),
                                                            Text(
                                                              '${e.agreement} KM',
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  height: 1.16),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: SvgPicture.asset(
                                                    'asset/icons/done.svg',
                                                    height: 23,
                                                    width: 30,
                                                    color: const Color(0xFF009254),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      )
                                      .toList(),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        );
      }),
    );
  }
}

// class SalesData {
//   SalesData(this.year, this.sales);
//
//   final String year;
//   final double sales;
// }

class SummaryData {
  String? month;
  double? distance;
  double? agreement;

  SummaryData({this.month, this.distance, this.agreement});
}
