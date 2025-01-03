import 'package:addrive/controller/auth_controller.dart';
import 'package:addrive/data/repository/repository.dart';
import 'package:addrive/controller/sign_in_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => Repository());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => SignInUpController());
  }
}