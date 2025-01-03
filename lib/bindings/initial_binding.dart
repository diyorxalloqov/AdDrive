import 'package:addrive/controller/inbox_controller.dart';
import 'package:addrive/controller/location_controller.dart';
// import 'package:addrive/controller/payment_controller.dart';
import 'package:addrive/data/repository/repository.dart';
import 'package:addrive/controller/owner_profile_controller.dart';
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