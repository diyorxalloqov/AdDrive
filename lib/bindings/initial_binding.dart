import 'package:flutter_texi_tracker/controller/inbox_controller.dart';
import 'package:flutter_texi_tracker/controller/location_controller.dart';
// import 'package:flutter_texi_tracker/controller/payment_controller.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/controller/owner_profile_controller.dart';
import 'package:get/instance_manager.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => Repository());
   Get.lazyPut(() => InboxController());
   Get.lazyPut(() => LocationController());
   Get.lazyPut(() => OwnerProfileController());
   // Get.lazyPut(() => PaymentController());
  }
}