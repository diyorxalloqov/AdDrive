import 'package:flutter/foundation.dart';
import 'package:flutter_texi_tracker/model/hive_model/user_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

const String userBoxName = 'userbox';

class AuthController extends GetxController{
  var box = Hive.box<User>(userBoxName);

  Future updateUser(User userModelUser) async{
    await box.put(0, userModelUser);
    update();
  }

  User? getUser(){
    return box.get(0);
  }

  Future<void> deleteUser()async{
    if (kDebugMode) {
      print('delete user');
    }
    await box.clear();
    update();
  }
}