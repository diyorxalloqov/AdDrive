import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/data/api/api_provider.dart';
import 'package:flutter_texi_tracker/data/dio_service/http_service_impl.dart';
import 'package:flutter_texi_tracker/model/bari_koi_location_model.dart';
import 'package:flutter_texi_tracker/model/base_settings/base_settings_model.dart';
import 'package:flutter_texi_tracker/model/base_settings/basic_setting.dart';
import 'package:flutter_texi_tracker/model/campaignListModel.dart';
import 'package:flutter_texi_tracker/model/daily_tracking_model.dart';
import 'package:flutter_texi_tracker/model/driver_list_model.dart';
import 'package:flutter_texi_tracker/model/driver_payment/driver_payment_model.dart';
import 'package:flutter_texi_tracker/model/driver_profile.dart';
import 'package:flutter_texi_tracker/model/driving_history_model.dart';
import 'package:flutter_texi_tracker/model/hive_model/user_model.dart';
import 'package:flutter_texi_tracker/model/live_data_model.dart';
import 'package:flutter_texi_tracker/model/privacy_policy_model.dart';
import 'package:flutter_texi_tracker/model/sign_up_model.dart';
import 'package:flutter_texi_tracker/model/success_message.dart';
import 'package:flutter_texi_tracker/model/summery/summery_model.dart';
import 'package:flutter_texi_tracker/model/vehicle_list_model.dart';
import 'package:get/get.dart';
import 'abstract_repository.dart';

class Repository implements AbstractRepo {
  late HttpServiceImpl _httpServiceImpl;

  Repository() {
    _httpServiceImpl = Get.put(HttpServiceImpl());
    _httpServiceImpl.init();
  }

  @override
  Future createUser(var data) async {
    try {} on Exception catch (e) {
      debugPrint(e.toString());
    }
    return;
  }

  @override
  Future <SignupModel?>postLoginUser(data) async {
    try {
      final response = await _httpServiceImpl.posRequest(ApiProvider.signIn, data);

      return signupResponseFromJson(response.data);
    } on Exception catch (e) {
      debugPrint('error : $e');

      return null;
    }
  }

  @override
  Future forgetPass(data) async {
    try {
      final response = await _httpServiceImpl.posRequest(ApiProvider.forgetPass, data);
      return response.data;
    } on Exception catch (e) {
      debugPrint('error : $e');

      return null;
    }
  }

  @override
  Future <SignupModel?>userRegistration(data) async {
    try {
      final response =
          await _httpServiceImpl.posRequest(ApiProvider.signUp, data);
      return signupResponseFromJson(response.data);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<LiveDataModel?> sendStopLocationData({userId, List<Map<String, dynamic>>? locations, trackingId}) async {
    try {
      final data = {
        'driver_id': '$userId',
        'tracking_id': trackingId,
        'locations': locations
      };

      final response = await _httpServiceImpl.posRequest(
          ApiProvider.stopDrivingLocationData, data);

      LiveDataModel liveData = LiveDataModel.fromJson(response.data);

      return liveData;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// Get location from bari koi api
  @override
  Future<BariKoiLocationModel?> getLocationFromBariKoi(longitudeResult, latitudeResult) async {
    String bariKoiUrl = 'https://barikoi.xyz/v1/api/search/reverse/MzIxNzo4UTRXOTNKRFk2/';
    try {
      final response = await _httpServiceImpl.getRequest("${bariKoiUrl}geocode?longitude=$longitudeResult&latitude=$latitudeResult&district=true&post_code=true&country=true&sub_district=true&union=true&pauroshova=true&location_type=true&division=true&address=true&area=true");

      return responseLocationFromJson(response.data);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future moveDriverLocationData(data) async {
    try {

      final response = await _httpServiceImpl.posRequest(ApiProvider.moveDrivingLocationData, data);

      return response.data;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  @override
  Future<DrivingHistory?> drivingHistory(data) async {
    try {
      final response =
          await _httpServiceImpl.posRequest(ApiProvider.drivingHistory, data);
      final drivingHistory = drivingHistoryFromJson(response.data);
      return drivingHistory;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<DriverPayment?> driverPayment(data) async {
    try {
      final response = await _httpServiceImpl.posRequest(ApiProvider.driverPayment, data);
      final driverPayment = driverPaymentFromJson(response.data);
      return driverPayment;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<DailyTrackingDetails?> drivingDailyTracking(data) async {
    try {
      final response = await _httpServiceImpl.posRequest(ApiProvider.dailyTracking, data);

      final trackingDetails = DailyTrackingDetails.fromJson(response.data);

      return trackingDetails;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<VehiclesListModel?> vehiclesList(data) async {
    try {
      final response =
          await _httpServiceImpl.posRequest(ApiProvider.driverVehicles, data);

      final vehiclesData = vehiclesListModelFromJson(response.data);

      return vehiclesData;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<DriverListModel?> driverList(data) async {
    try {
      final response =
          await _httpServiceImpl.posRequest(ApiProvider.driverList, data);

      final driverListData = DriverListModel.fromJson(response.data);

      return driverListData;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<DriverProfileModel?> driverProfile(data) async {
    try {
      final response =
          await _httpServiceImpl.posRequest(ApiProvider.driverProfile, data);

      final driverProfileData = DriverProfileModel.fromJson(response.data);

      return driverProfileData;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<SummeryModel?> driverSummery(data) async {
    try {
      final response =
          await _httpServiceImpl.posRequest(ApiProvider.summery, data);

      final driverSummery = SummeryModel.fromJson(response.data);

      return driverSummery;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<SuccessMessage?> updatePassword(data) async {
    try {
      final response = await _httpServiceImpl.posRequest(ApiProvider.updatePassword, data);
      SuccessMessage message = SuccessMessage.fromJson(response.data);
      return message;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<BaseSettingsModel?> baseSettings() async {
    try {
      final response = await _httpServiceImpl.posRequest(ApiProvider.baseSettings, '');
      final baseSettings = BaseSettingsModel.fromJson(response.data);
      return baseSettings;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<BasicSetting?> basicSettings() async {
    try {
      final response = await _httpServiceImpl.getRequest(ApiProvider.basicSetting);
      final baseSettings = BasicSetting.fromJson(response.data);
      return baseSettings;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<PrivacyPolicyModel?> privacyPolicy() async{
    try {
      final response = await _httpServiceImpl.getRequest(ApiProvider.privacyPolicy);
      final privacyPolicy = PrivacyPolicyModel.fromJson(response.data);
      return privacyPolicy;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<PrivacyPolicyModel?> termsConditions() async{
    try {
      final response = await _httpServiceImpl.getRequest(ApiProvider.termsConditions);
      final privacyPolicy = PrivacyPolicyModel.fromJson(response.data);
      return privacyPolicy;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future <User?>uploadProfile(data) async{
    try {
      final response = await _httpServiceImpl.posRequest(ApiProvider.uploadProfile, data);
      final privacyPolicy = User.fromJson(response.data['data']);
      return privacyPolicy;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }




}
