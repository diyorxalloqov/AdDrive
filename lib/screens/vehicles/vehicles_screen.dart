import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/controller/vehicles_list_controller.dart';
import 'package:flutter_texi_tracker/model/vehicle_list_model.dart';
import 'package:flutter_texi_tracker/widgets/error_screen.dart';
import 'package:flutter_texi_tracker/widgets/no_data_found_widget.dart';
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
                title: Text(
                  'vehicles'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                leading: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
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
                                    Text(
                                      '${data?.vehicleName}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),

                                    /// Mileage mpg and year
                                    buildMialeageMpgYear(data!),

                                    /// Brand, displacement and engine
                                    buildBrandDisplacementEngine(data),

                                    /// Abs, Model, HP
                                    buildAbsModelHp(data),

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
                                                    Text(
                                                      'fitness'.tr,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          height: 1.8,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
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
                                                  child: buildColumn(data),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'license'.tr,
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        height: 1.8,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
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
                                          const SizedBox(
                                            height: 10,
                                          ),
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

  Container buildAbsModelHp(Datum data) {
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
                    const Text(
                      'ABS',
                      style: TextStyle(
                          color: Colors.grey,
                          height: 1.8,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      data.abs ?? 'N/A',
                      style: const TextStyle(
                          height: 1.4,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'model'.tr,
                      style: const TextStyle(
                          color: Colors.grey,
                          height: 1.8,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      data.vehicleModel ?? 'N/A',
                      style: const TextStyle(
                          height: 1.4,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'HP',
                    style: TextStyle(
                        color: Colors.grey,
                        height: 1.8,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
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

  Container buildBrandDisplacementEngine(Datum data) {
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
                    Text(
                      'brand'.tr,
                      style: const TextStyle(
                          color: Colors.grey,
                          height: 1.8,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${data.vehicleName}',
                      maxLines: 1,
                      style: const TextStyle(
                          height: 1.4,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'displacement'.tr,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.grey,
                          height: 1.8,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${data.displacement}',
                      style: const TextStyle(
                          height: 1.4,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'engine'.tr,
                    style: const TextStyle(
                        color: Colors.grey,
                        height: 1.8,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
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

  Container buildMialeageMpgYear(Datum data) {
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
                    Text(
                      'mileage'.tr,
                      style: const TextStyle(
                          color: Colors.grey,
                          height: 1.8,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${data.mileage}',
                      maxLines: 1,
                      style: const TextStyle(
                          height: 1.4,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MPG',
                      style: TextStyle(
                          color: Colors.grey,
                          height: 1.8,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${data.mpg}',
                      maxLines: 1,
                      style: const TextStyle(
                          height: 1.4,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'year'.tr,
                    style: const TextStyle(
                        color: Colors.grey,
                        height: 1.8,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
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

  Column buildColumn(Datum data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'route_permit'.tr,
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: Colors.grey,
              height: 1.8,
              fontSize: 11,
              fontWeight: FontWeight.w400),
        ),
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
