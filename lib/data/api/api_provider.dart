class ApiProvider {
  ///Live url
  static const String baseUrl = 'https://adgari.onesttech.com'; //'https://addrive.uz/api/pages/index';

  static const String signIn = '$baseUrl/api/auth/login';
  static const String signUp = '$baseUrl/api/auth/register';
  static const String forgetPass = '$baseUrl/api/auth/forget-password-request';
  static const String stopDrivingLocationData = '$baseUrl/api/driver/get-live-data';
  static const String moveDrivingLocationData = '$baseUrl/api/driver/driver-is-moving';
  static const String webLogin = '$baseUrl/users/login';

  static const String drivingHistory = '$baseUrl/api/driver/history';
  static const String driverPayment = '$baseUrl/api/driver/payment-history';
  static const String dailyTracking = '$baseUrl/api/driver/history-details';

  static const String driverVehicles = '$baseUrl/api/driver/vehicles';
  static const String driverList = '$baseUrl/api/driver/list-view';
  static const String driverProfile = '$baseUrl/api/driver/driver-profile';
  static const String summery = '$baseUrl/api/driver/summary';
  static const String updatePassword = '$baseUrl/api/auth/password-update';
  static const String baseSettings = '$baseUrl/api/base-setting'; // favqulotda qo'ngiroq raqami va email
  static const String basicSetting = '$baseUrl/api/basic-setting';
  static const String privacyPolicy = '$baseUrl/api/privacy-policy';
  static const String termsConditions = '$baseUrl/api/terms-condition';
  static const String uploadProfile = '$baseUrl/api/auth/avatar-update';
  static const String campaignList = '$baseUrl/api/driver/campaign-list';
}
