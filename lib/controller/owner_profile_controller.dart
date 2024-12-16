import 'package:flutter/foundation.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/model/driving_history_model.dart';
import 'package:get/get.dart';

class OwnerProfileController extends GetxController{
  final Repository _repository = Get.find();
  final AuthController _authController = Get.find();

  Rx<DrivingHistory?> historyData = Rx<DrivingHistory?>(null);

  OwnerProfileController(){
    getDrivingHistory();
  }

  Future getDrivingHistory()async{
    if (kDebugMode) {
      print('id: ${_authController.getUser()?.id}');
    }
    var data =
    {
      'driver_id': _authController.getUser()?.id
    };

    final response = await _repository.drivingHistory(data);
    historyData.value = response;
  }
}