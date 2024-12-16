import 'package:flutter/foundation.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/model/vehicle_list_model.dart';
import 'package:get/get.dart';

class VehicleListController extends GetxController with StateMixin<VehiclesListModel>{

  final Repository _repository = Get.find();
  final AuthController _authController = Get.find();

  VehicleListController(){
    getVehicleListData();
  }

  Future getVehicleListData()async{
    final driverId = _authController.getUser()?.id;
    if (kDebugMode) {
      print('id: $driverId');
    }
    final data =
    {
      'driver_id': driverId
    };

    final response = await _repository.vehiclesList(data);
    if(response != null){
      change(response, status: RxStatus.success());
    }else{
      change(null, status: RxStatus.empty());
    }
  }
}