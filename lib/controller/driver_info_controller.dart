import 'dart:convert';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/data/api/api_provider.dart';
import 'package:flutter_texi_tracker/screens/bottom_navigation/bottom_nav_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../model/hive_model/user_model.dart';
import 'dart:typed_data';
import 'package:signature/signature.dart';


class DriverInfoController extends GetxController {


  var isLoading = false.obs;


  var isDamage = false.obs;
  var isWashed = false.obs;
  var isDeclare = RxnString();


  final dioInstance = dio.Dio();
  final AuthController authController = Get.find<AuthController>();
  final signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );




  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final dateController = TextEditingController();
  final driverNameController = TextEditingController();
  final vehicleModelController = TextEditingController();




  var selectedImages = <File>[].obs;




  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );


    if (pickedDate != null) {
      dateController.text = dateFormat.format(pickedDate);
      update();
    }
  }






  Future<void> saveDriverInfo() async {
    isLoading.value = true;
    String url = '${ApiProvider.baseUrl}/api/driver/vehicle-inspection';
    User? user = authController.getUser();
    String? token = user?.accessToken;
    List<dio.MultipartFile> imageFiles = [];


    for (var image in selectedImages) {
      String fileName = image.path.split('/').last;
      dio.MultipartFile multipartImage = await dio.MultipartFile.fromFile(
        image.path,
        filename: fileName,
      );
      imageFiles.add(multipartImage);
    }


    if (signatureController.isNotEmpty) {
      Uint8List? signatureData = await signatureController.toPngBytes();
      if (signatureData != null) {
        String base64Signature = base64Encode(signatureData);
        dio.FormData formData = dio.FormData.fromMap({
          'date': dateController.text,
          'car_make_model': vehicleModelController.text,
          'full_name': driverNameController.text,
          'no_damage': isDamage.value ? 1 : 0,
          'is_washed': isWashed.value ? 1 : 0,
          'declaration': isDeclare.value == "Yes" ? 1 : 0,
          'vehicle_images[]': imageFiles,
          'driver_signature': base64Signature,
        });
        try {
          dio.Response response = await dioInstance.post(
            url,
            data: formData,
            options: dio.Options(
              headers: {
                "Content-Type": "application/json",
                'Authorization': 'Bearer $token'
              },
              validateStatus: (status) => status != null,
            ),
          );
          if (response.statusCode == 200) {
            if (response.data['success'] == true) {
              Fluttertoast.showToast(
                  backgroundColor: Colors.deepOrangeAccent, msg: '${response.data['message']}'
              );
              Get.to(() => const BottomNavScreen());
              clearFields();
            } else {
              Fluttertoast.showToast(
                  backgroundColor: Colors.deepOrangeAccent, msg: 'Failed: ${response.data['message']}'
              );
            }
          } else if (response.statusCode == 302) {
            debugPrint('Redirection: Please check the redirected URL.');
          } else {
            debugPrint('Unexpected response code: ${response.statusCode}');
          }
        } catch (e) {
          Fluttertoast.showToast(
              backgroundColor: Colors.deepOrangeAccent,
              msg: 'Error: $e'
          );
        } finally {
          isLoading.value = false;
        }
      }
    }
  }






  void clearFields() {
    dateController.clear();
    driverNameController.clear();
    vehicleModelController.clear();
    isDamage.value = false;
    isWashed.value = false;
    isDeclare.value = null;
    selectedImages.clear();
    signatureController.clear();
  }
}

