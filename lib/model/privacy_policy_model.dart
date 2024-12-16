class PrivacyPolicyModel {
  bool? success;
  Data? data;

  PrivacyPolicyModel({this.success, this.data});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? en;
  String? bn;

  Data({this.en, this.bn});

  Data.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    bn = json['bn'];
  }
}
