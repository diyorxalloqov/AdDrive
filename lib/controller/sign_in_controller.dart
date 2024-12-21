import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/controller/location_controller.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/model/hive_model/user_model.dart';
import 'package:flutter_texi_tracker/screens/main_screen/ui/main_screen.dart';
import 'package:get/get.dart';

class SignInUpController extends GetxController {
  final Repository _repository = Get.find();
  final AuthController _authController = Get.find<AuthController>();
  LocationController locationController = Get.find<LocationController>();
  RxBool loading = false.obs;

  Future userLogin({@required String? email, required String password}) async {
    loadingOn();

    final data = {
      'email': email,
      'password': password,
    };

    final response = await _repository.postLoginUser(data);

    if (response != null) {
      User? user = response.user;

      if (user != null) {
        _authController.updateUser(user);

        ///update some basic data to firebase
        final map = {
          'is_driving': 0,
          'last_login': Timestamp.now().seconds,
          'uid': '${user.id}'
        };

        locationController.updateUserData(map: map, uid: user.id);
        Get.to(const MainScreen());

        loadingOff();
      } else {
        loadingOff();

        final message = response.validation?.email ??
            response.validation?.phone ??
            response.validation?.confirmPassword ??
            response.validation?.password ??
            response.message;
        Get.snackbar('$message', '',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF000000),
            colorText: const Color(0xFFFFFFFF));
      }
    } else {
      loadingOff();

      Get.snackbar('please Try again later', '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF000000),
          colorText: const Color(0xFFFFFFFF));
    }
  }

  Future userRegistration(
      {@required String? name,
      @required String? phone,
      @required String? email,
      @required String? password,
      @required String? confirmPassword}) async {
    loadingOn();

    final data = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'is_mobile': 1
    };

    final response = await _repository.userRegistration(data);

    if (response != null) {
      User? user = response.user;

      if (user != null) {
        _authController.updateUser(user);

        ///update some basic data to firebase
        final map = {
          'is_driving': 0,
          'last_login': Timestamp.now().seconds,
          'uid': '${user.id}'
        };

        locationController.updateUserData(map: map, uid: user.id);

        Future.delayed(const Duration(seconds: 3), () {
          locationController.startListening();
          locationController.deleteDataAndSendToServer(uid: user.id);
          locationController.deleteAllDataFromLocal(uid: user.id);
        });

        Get.snackbar('Registration successful', '',
            snackPosition: SnackPosition.BOTTOM);

        Get.to(const MainScreen());

      } else {
        // Get.snackbar('Registration failed', '',snackPosition: SnackPosition.BOTTOM);
        final message = response.validation?.email ??
            response.validation?.phone ??
            response.validation?.confirmPassword ??
            response.validation?.password ??
            response.message;
        Get.snackbar('$message', '', snackPosition: SnackPosition.BOTTOM);
      }

      loadingOff();
    } else {
      loadingOff();
      Get.snackbar('please Try again later', '',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  loadingOff() {
    loading.value = false;
    update();
  }

  loadingOn() {
    loading.value = true;
    update();
  }
}
