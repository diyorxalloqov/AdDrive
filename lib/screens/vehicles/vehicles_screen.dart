import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/controller/vehicles_list_controller.dart';
import 'package:flutter_texi_tracker/model/vehicle_list_model.dart';
import 'package:flutter_texi_tracker/widgets/error_screen.dart';
import 'package:flutter_texi_tracker/widgets/no_data_found_widget.dart';
import 'package:flutter_texi_tracker/widgets/space_widget.dart';
import 'package:get/get.dart';

class VehiclesScreen extends StatelessWidget {
  final controller = Get.put(VehicleListController());
  final bool? isBottomNavbar;
  VehiclesScreen({super.key, this.isBottomNavbar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isBottomNavbar != null
            ? null
            : AppBar(
                title: Text('vehicles'.tr,
                    style: context.theme.textTheme.labelMedium),
                leading: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      size: 20,
                    )),
              ),
        body: controller.obx(
          (state) => state?.data?.isNotEmpty == true
              ? ListView.builder(
                  itemCount: state?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final data = state?.data?[index];
                    return Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: Card(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 80, left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${data?.vehicleName}',
                                        style: context
                                            .theme.textTheme.labelMedium),
                                    const SpaceHeight(height: 17),

                                    /// Mileage mpg and year
                                    buildMialeageMpgYear(data!, context),

                                    /// Brand, displacement and engine
                                    buildBrandDisplacementEngine(data, context),

                                    /// Abs, Model, HP
                                    buildAbsModelHp(data, context),

                                    /// All permission status
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 4),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('fitness'.tr,
                                                        style: context
                                                            .theme
                                                            .textTheme
                                                            .labelMedium),
                                                    Text(
                                                      '${data.fitness}',
                                                      style: TextStyle(
                                                          color: data.fitness
                                                                      ?.contains(
                                                                          'Yes') ==
                                                                  true
                                                              ? Colors.green
                                                              : Colors.red,
                                                          height: 1.4,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: buildColumn(
                                                      data, context),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('license'.tr,
                                                      style: context
                                                          .theme
                                                          .textTheme
                                                          .labelMedium),
                                                  Text(
                                                    data.license ?? 'N/A',
                                                    style: TextStyle(
                                                        color: data.license!
                                                                .contains('Yes')
                                                            ? Colors.green
                                                            : Colors.red,
                                                        height: 1.4,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SpaceHeight(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: Image.network(
                              '${data.carImage}',
                              fit: BoxFit.contain,
                              height: 100,
                              width: 200,
                            ),
                          )
                        ],
                      ),
                    );
                  })
              : const NoDataFoundWidget(),
          onEmpty: ErrorScreen(
            title: 'No Vehicle found',
            subTitle: 'Add your vehicle',
            onPressed: () async {
              await controller.getVehicleListData();
            },
          ),
          // onError: (error) => Text(error)
        ));
  }

  Container buildAbsModelHp(Datum data, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ABS', style: context.theme.textTheme.labelMedium),
                    Text(
                      data.abs ?? 'N/A',
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('model'.tr,
                        style: context.theme.textTheme.labelMedium),
                    Text(
                      data.vehicleModel ?? 'N/A',
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('HP', style: context.theme.textTheme.headlineSmall),
                  Text(
                    data.horsePower ?? 'N/A',
                    style: const TextStyle(
                        height: 1.4, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider()
        ],
      ),
    );
  }

  Container buildBrandDisplacementEngine(Datum data, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('brand'.tr,
                        style: context.theme.textTheme.labelMedium),
                    Text(
                      '${data.vehicleName}',
                      maxLines: 1,
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('displacement'.tr,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: context.theme.textTheme.labelMedium),
                    Text(
                      '${data.displacement}',
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('engine'.tr,
                      style: context.theme.textTheme.headlineSmall),
                  Text(
                    data.engine ?? 'N/A',
                    style: const TextStyle(
                        height: 1.4, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider()
        ],
      ),
    );
  }

  Container buildMialeageMpgYear(Datum data, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('mileage'.tr,
                        style: context.theme.textTheme.labelMedium),
                    Text(
                      '${data.mileage}',
                      maxLines: 1,
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MPG', style: context.theme.textTheme.labelMedium),
                    Text(
                      '${data.mpg}',
                      maxLines: 1,
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('year'.tr, style: context.theme.textTheme.headlineSmall),
                  Text(
                    '${data.vehicleMakeYear}',
                    style: const TextStyle(
                        height: 1.4, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider()
        ],
      ),
    );
  }

  Column buildColumn(Datum data, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('route_permit'.tr,
            textAlign: TextAlign.start,
            style: context.theme.textTheme.headlineSmall),
        Text(
          data.routePermit ?? 'N/A',
          style: TextStyle(
              color:
                  data.routePermit!.contains('Yes') ? Colors.green : Colors.red,
              height: 1.4,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
