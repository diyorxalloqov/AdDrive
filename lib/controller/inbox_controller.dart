import 'package:flutter/material.dart';
import 'package:addrive/controller/auth_controller.dart';
import 'package:get/get.dart';

class InboxController extends GetxController{
  final AuthController _authController = Get.find();
  RxBool isLoading = false.obs;

  // RxList<InboxDataList>inboxList = <InboxDataList>[].obs;


  InboxController(){
    getInboxList();
  }

  Future getInboxList()async{
    isLoading.value = !isLoading.value;
    final driverId = _authController.getUser()?.id;
    debugPrint('id: $driverId');
    isLoading.value = !isLoading.value;
  }
}