import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:addrive/controller/summery_controller.dart';
import 'package:addrive/global/imports/app_imports.dart';
import 'package:addrive/global/widgets/decoration_widget.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SummeryScreen extends StatelessWidget {
  final summeryList = {};

  SummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SummeryController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: context.isDarkMode ? Colors.white : Colors.black,
            size: 25.0),
        title: Text('summery'.tr,
            style: context.theme.textTheme.bodyLarge?.copyWith(fontSize: 16)),
      ),
      body: Obx(() {
        return Stack(
          children: [
            controller.isLoading.isTrue
                ? const Center(child: Loading())
                : const SizedBox(),
            controller.driverSummeryData?.value != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(12),
                            height: Get.size.height / 3,
                            decoration: decoration(context),
                            child: SfCartesianChart(
                                primaryXAxis: const CategoryAxis(),
                                series: <LineSeries<SalesData, String>>[
                                  LineSeries<SalesData, String>(
                                      dataSource: controller.summeryList,
                                      xValueMapper: (SalesData sales, _) =>
                                          sales.year,
                                      yValueMapper: (SalesData sales, _) =>
                                          double.parse(sales.sales))
                                ])),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: decoration(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          Assets.drawerIconVehicles,
                                          height: 23,
                                          width: 30,
                                          color: CustomColors().mainColor(1)),
                                      const SpaceHeight(height: 4),
                                      Text('car'.tr,
                                          style: context
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(fontSize: 16)),
                                      const SpaceHeight(height: 4),
                                      Text(
                                          controller.driverSummeryData?.value
                                                  ?.totalCar
                                                  .toString() ??
                                              '',
                                          style: context
                                              .theme.textTheme.headlineSmall),
                                    ],
                                  ),
                                ),
                              ),
                              const SpaceWidth(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: decoration(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          Assets.iconsDistanceSummery,
                                          height: 23,
                                          width: 30,
                                          color: CustomColors().mainColor(1)),
                                      Text('distance'.tr,
                                          style: context
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(fontSize: 16)),
                                      Text(
                                          '${controller.driverSummeryData?.value?.totalDistance}',
                                          style: context
                                              .theme.textTheme.headlineSmall),
                                    ],
                                  ),
                                ),
                              ),
                              const SpaceWidth(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: decoration(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.iconsEarn2,
                                        height: 23,
                                        width: 30,
                                        color: CustomColors().mainColor(1),
                                      ),
                                      Text('earn'.tr,
                                          style: context
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(fontSize: 16)),
                                      Text(
                                          '${controller.driverSummeryData?.value?.amount} ${controller.currency ?? ''}',
                                          style: context
                                              .theme.textTheme.headlineSmall),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: controller.driverSummeryData?.value?.summary
                                      ?.isNotEmpty !=
                                  true
                              ? true
                              : false,
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.all(18),
                            decoration: decoration(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('summery'.tr,
                                    style: context.theme.textTheme.bodyLarge
                                        ?.copyWith(fontSize: 16)),
                                const SpaceHeight(height: 6),
                                const Divider(),
                                if (controller.driverSummeryData != null)
                                  Column(
                                    children: controller
                                        .driverSummeryData!.value!.summary!
                                        .map(
                                          (e) => Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text('${e.month}',
                                                        style: context
                                                            .theme
                                                            .textTheme
                                                            .headlineSmall),
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
                                                                  Assets
                                                                      .iconsPointArrow,
                                                                  height: 22,
                                                                  width: 22),
                                                              Text(
                                                                  '${e.distance} KM',
                                                                  style: context
                                                                      .theme
                                                                      .textTheme
                                                                      .headlineSmall),
                                                            ],
                                                          ),
                                                          const SpaceHeight(
                                                              height: 6),
                                                          Wrap(
                                                            spacing: 8,
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  Assets
                                                                      .iconsPointArrowMark,
                                                                  height: 22,
                                                                  width: 22),
                                                              Text(
                                                                  '${e.agreement} KM',
                                                                  style: context
                                                                      .theme
                                                                      .textTheme
                                                                      .headlineSmall),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: SvgPicture.asset(
                                                      Assets.iconsDone,
                                                      height: 23,
                                                      width: 30,
                                                      color: const Color(
                                                          0xFF009254),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SpaceHeight(height: 6),
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
