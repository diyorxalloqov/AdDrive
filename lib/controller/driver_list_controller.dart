import 'package:flutter/foundation.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/model/driver_list_model.dart';
import 'package:get/get.dart';

class DriverListController extends GetxController{
  final Repository _repository = Get.find();
  final AuthController _authController = Get.find();
  RxBool isLoading = false.obs;

  Rx<DriverListModel?> driverListData = Rx<DriverListModel?>(null);

  DriverListController(){
    getDriverList();
  }

  Future getDriverList()async{
    isLoading.value = !isLoading.value;
    final driverId = _authController.getUser()?.id;
    if (kDebugMode) {print('id: $driverId');}
    final data = {'driver_id': driverId};
    final response = await _repository.driverList(data);
    driverListData.value = response;
    isLoading.value = !isLoading.value;
  }
}