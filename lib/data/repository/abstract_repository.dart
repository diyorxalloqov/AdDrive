import 'package:flutter/cupertino.dart';
import 'package:addrive/model/base_settings/base_settings_model.dart';
import 'package:addrive/model/base_settings/basic_setting.dart';
import 'package:addrive/model/daily_tracking_model.dart';
import 'package:addrive/model/driver_list_model.dart';
import 'package:addrive/model/driver_payment/driver_payment_model.dart';
import 'package:addrive/model/driver_profile.dart';
import 'package:addrive/model/driving_history_model.dart';
import 'package:addrive/model/privacy_policy_model.dart';
import 'package:addrive/model/sign_up_model.dart';
import 'package:addrive/model/success_message.dart';
import 'package:addrive/model/summery/summery_model.dart';
import 'package:addrive/model/vehicle_list_model.dart';

abstract class AbstractRepo {
  Future <SignupModel?>postLoginUser(var data);
  Future <SignupModel?>userRegistration(var data);
  Future forgetPass(var data);
  Future sendStopLocationData({@required userId,@required List<Map<String,dynamic>> locations});
  Future getLocationFromBariKoi(longitudeResult, latitudeResult);
  Future createUser(var data);
  Future moveDriverLocationData(data);
  Future <DrivingHistory?>drivingHistory(data);
  Future <DriverPayment?>driverPayment(data);
  Future <DailyTrackingDetails?>drivingDailyTracking(data);
  Future <VehiclesListModel?>vehiclesList(data);
  Future <DriverListModel?>driverList(data);
  Future <DriverProfileModel?>driverProfile(data);
  Future <SummeryModel?>driverSummery(data);
  Future <SuccessMessage?>updatePassword(data);
  Future <BaseSettingsModel?>baseSettings();
  Future <BasicSetting?>basicSettings();
  Future <PrivacyPolicyModel?>privacyPolicy();
  Future <PrivacyPolicyModel?>termsConditions();
  Future uploadProfile(data);
}