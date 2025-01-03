// import 'package:flutter/foundation.dart';
// import 'package:addrive/controller/auth_controller.dart';
// import 'package:addrive/data/local_data/shared_preference.dart';
// import 'package:addrive/data/repository/repository.dart';
// import 'package:addrive/model/driver_payment/driver_payment_model.dart';
// import 'package:get/get.dart';
//
// class PaymentController extends GetxController with StateMixin<DriverPayment> {
//   final Repository _repository = Get.find();
//   final AuthController _authController = Get.find();
//   String? currency;
//
//   PaymentController(){
//     getCurrency();
//     getDriverPayment();
//   }
//   getCurrency()async{
//     currency = await getValue('currency');
//     update();
//   }
//
//   Future getDriverPayment()async{
//     final driverId = _authController.getUser()?.id;
//     if (kDebugMode) {
//       print('id: $driverId');
//     }
//     final data =
//     {
//       'driver_id': driverId
//     };
//
//     final response = await _repository.driverPayment(data);
//     if(response?.data?.isNotEmpty == true){
//       change(response, status: RxStatus.success());
//     }else{
//       change(null, status: RxStatus.empty());
//     }
//   }
// }