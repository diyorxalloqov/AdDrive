class BaseSettingsModel {
  bool? success;
  Data? data;

  BaseSettingsModel({this.success, this.data});

  BaseSettingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? phone;
  String? email;
  bool? canDrive;

  Data({this.phone, this.email, this.canDrive});

  Data.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    canDrive = json['can_drive'];
  }
}
