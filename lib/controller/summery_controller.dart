import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/data/local_data/shared_preference.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/model/summery/summery_model.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class SummeryController extends GetxController{

  final Repository _repository = Get.find();
  final AuthController _authController = Get.find();

  Rx<SummeryModel?>? driverSummeryData = Rx<SummeryModel?>(null);
  // driverSummeryData.value.graph.data
  RxList<SalesData> summeryList = <SalesData>[].obs;
  RxBool isLoading = false.obs;
  String? currency;


  SummeryController(){
    getCurrency();
    getDriverList();
  }
  getCurrency()async{
    currency = await getValue('currency');
    update();
  }

  Future getDriverList()async{
    isLoading.value = !isLoading.value;
    final driverId = _authController.getUser()?.id;
    debugPrint('id: $driverId');
    final data = {'user_id': driverId};

    final response = await _repository.driverSummery(data);
    driverSummeryData?.value = response;
    isLoading.value = !isLoading.value;
    driverSummeryData?.value?.graph?.data?.forEach((element) {
      summeryList.add(SalesData(element.month! , element.distance));
    });
    summeryList.map((element) => debugPrint(element.sales)).toList();
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final String sales;
}