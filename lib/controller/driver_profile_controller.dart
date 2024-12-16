import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/data/local_data/shared_preference.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/model/driver_profile.dart';
import 'package:flutter_texi_tracker/model/hive_model/user_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class DriverProfileController extends GetxController {
  final Repository _repository = Get.find();
  AuthController authController = Get.find();
  RxBool isLoading = false.obs;
  Rx <String?> avatarRX = Rx<String?>(null);

  Rx<DriverProfileModel?> driverProfile = Rx<DriverProfileModel?>(null);

  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  String? currency;

  DriverProfileController() {
    getCurrency();
    avatarRX.value = authController.getUser()!.avatar!;
    getDriverProfile();
  }
  getCurrency()async{
    currency = await getValue('currency');
    update();
  }

  imgFromCamera() async {
    pickedFile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getPickSingleImage();
  }

  imgFromGallery() async {
    pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getPickSingleImage();
  }

  Future<void> getPickSingleImage() async {
    int? id = authController.getUser()?.id;
    String? token = authController.getUser()?.accessToken;

    if (pickedFile != null) {
      final body = dio.FormData.fromMap({
        'user_id': id,
      });

      body.files.add(MapEntry('avatar', await dio.MultipartFile.fromFile(pickedFile?.path ?? '', filename: pickedFile?.path)));

      final updateHiveData = await _repository.uploadProfile(body);

      if(updateHiveData != null){
       User user =  User(
          id: updateHiveData.id,
         name: updateHiveData.name,
         phone: updateHiveData.phone,
         phoneVerifyToken: updateHiveData.phoneVerifyToken,
         isPhoneVerified: updateHiveData.isPhoneVerified,
         phoneVerifiedAt: updateHiveData.phoneVerifiedAt,
         phoneVerifyExpire: updateHiveData.phoneVerifyExpire,
         email: updateHiveData.email,
         emailVerifyToken: updateHiveData.emailVerifyToken,
         isEmailVerified: updateHiveData.isEmailVerified,
         emailVerifiedAt: updateHiveData.emailVerifiedAt,
         emailVerifyExpire: updateHiveData.emailVerifyExpire,
         avatarId: updateHiveData.avatarId,
         type: updateHiveData.type,
         statusId: updateHiveData.statusId,
         isBanned: updateHiveData.isBanned,
         bannedAt: updateHiveData.bannedAt,
         unbannedAt: updateHiveData.unbannedAt,
         lastLoginAt: updateHiveData.lastLoginAt,
         lastLogoutAt: updateHiveData.lastLogoutAt,
         lastLoginIp: updateHiveData.lastLoginIp,
         loginAccess: updateHiveData.loginAccess,
         deletedAt: updateHiveData.deletedAt,
         createdAt: updateHiveData.createdAt,
         updatedAt: updateHiveData.updatedAt,
         avatar: updateHiveData.avatar,
          accessToken: token,
        );
        authController.updateUser(user);
        authController.update();
       avatarRX.value = authController.getUser()!.avatar!;
       DriverProfileController().update();
      }
    }
  }

  Future getDriverProfile() async {
    isLoading.value = !isLoading.value;
    final driverId = authController.getUser()?.id;
    final data = {'user_id': driverId};
    final response = await _repository.driverProfile(data);
    driverProfile.value = response;
    isLoading.value = !isLoading.value;
  }
}
