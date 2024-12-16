import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/model/register_response_model.dart';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_texi_tracker/data/api/api_provider.dart';
import 'package:flutter_texi_tracker/screens/splash_screen/splash_screen.dart';
import 'package:flutter_texi_tracker/widgets/custom_dialog_image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class RegistrationProvider extends ChangeNotifier{


  final formKey = GlobalKey<FormState>();

  RegisterResponseModel? registerResponse;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final zipController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final carMakeController = TextEditingController();
  final carModelController = TextEditingController();
  final carDetailsController = TextEditingController();




  dio.Dio dioInstance = dio.Dio();
  String? gender;




  File? carFrontSiteImagePath;
  File? carBackSiteImagePath;
  File? driverSideImagePath;
  File? passengerSideImagePath;
  File? licenseFrontImagePath;
  File? licenseBackImagePath;
  int intIndex = 0;
  bool isLoadingValue = false;


  int get index => intIndex;


  set index(int value) {
    intIndex = value;
    notifyListeners();
  }


  bool get isLoading => isLoadingValue;


  set isLoading(bool value) {
    isLoadingValue = value;
    notifyListeners();
  }




  Future<dynamic> carFrontPickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            carFrontSiteImagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            carFrontSiteImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
  }


  Future<dynamic> carBackPickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            carBackSiteImagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            carBackSiteImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
  }


  Future<dynamic> driverSidePickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            driverSideImagePath = File(image!.path);
            notifyListeners();


          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            driverSideImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
  }


  Future<dynamic> passengerSidePickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            passengerSideImagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            passengerSideImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
  }


  Future<dynamic> licenseFrontPickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            licenseFrontImagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            licenseFrontImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
  }


  Future<dynamic> licenseBackPickImage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogImagePicker(
          onCameraClick: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            licenseBackImagePath = File(image!.path);
            notifyListeners();
          },
          onGalleryClick: () async {
            final ImagePicker pickerGallery = ImagePicker();
            final XFile? imageGallery = await pickerGallery.pickImage(
                source: ImageSource.gallery,
                maxHeight: 300,
                maxWidth: 300,
                imageQuality: 90);
            licenseBackImagePath = File(imageGallery!.path);
            notifyListeners();
          },
        );
      },
    );
  }


  Future<void> registerUser(context) async {
    isLoading = true;
    String url = '${ApiProvider.baseUrl}/api/auth/register';
    debugPrint('Base Url : $url');
    var carFrontSiteFile = carFrontSiteImagePath!.path.split('/').last;
    var carBackSiteFile = carBackSiteImagePath!.path.split('/').last;
    var driverSiteFile = driverSideImagePath!.path.split('/').last;
    var passengerSiteFile = passengerSideImagePath!.path.split('/').last;
    var licenseFrontSiteFile = licenseFrontImagePath!.path.split('/').last;
    var licenseBackSiteFile = licenseBackImagePath!.path.split('/').last;
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'first_name': firstNameController.text,
        'last_name' : lastNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'zip_code': zipController.text,
        'password': passwordController.text,
        'password_confirmation': passwordConfirmationController.text,
        'is_mobile': 1,
        'car_make': carMakeController.text,
        'car_model': carModelController.text,
        'car_details': carDetailsController.text,
        'front_side_img': carFrontSiteImagePath != null
            ? await dio.MultipartFile.fromFile(carFrontSiteImagePath!.path, filename: carFrontSiteFile)
            : null,
        'back_side_img': carBackSiteImagePath != null
            ? await dio.MultipartFile.fromFile(carBackSiteImagePath!.path, filename: carBackSiteFile)
            : null,
        'driver_side_img': driverSideImagePath != null
            ? await dio.MultipartFile.fromFile(driverSideImagePath!.path, filename: driverSiteFile)
            : null,
        'passenger_side_img': carBackSiteImagePath != null
            ? await dio.MultipartFile.fromFile(passengerSideImagePath!.path, filename: passengerSiteFile)
            : null,
        'license_front_side_img': licenseFrontImagePath != null
            ? await dio.MultipartFile.fromFile(licenseFrontImagePath!.path, filename: licenseFrontSiteFile)
            : null,
        'license_back_side_img': licenseBackImagePath != null
            ? await dio.MultipartFile.fromFile(licenseBackImagePath!.path, filename: licenseBackSiteFile)
            : null,
      });
      formData.fields.map((e) => debugPrint(e.value)).toList();
      var response = await dioInstance.post(url, data: formData);
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        registerResponse = RegisterResponseModel.fromJson(response.data);
        Navigator.push(context,  MaterialPageRoute(builder: (context) => const SplashScreen()),);
        Fluttertoast.showToast(msg: "Registration Successfully done");
        isLoading = false;
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: response.data["message"] ?? "");
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      // Handle specific errors
      Fluttertoast.showToast(msg: "Something went wrong");
      isLoading = false;
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }
}
