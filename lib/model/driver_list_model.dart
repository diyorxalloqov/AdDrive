class DriverListModel {
  bool? status;
  List<DataList>? data;

  DriverListModel({this.status, this.data});

  factory DriverListModel.fromJson(Map<String, dynamic> json) {
    return DriverListModel(
      status: json['status'],
      data: List<DataList>.from(json["data"].map((x) => DataList.fromJson(x))),
    );
  }
}

class DataList {
  int? id;
  String? phone;
  String? name;
  String? vehicleNumber;
  String? avatar;
  String? currentAddress;

  DataList(
      {this.id,
      this.phone,
      this.name,
      this.vehicleNumber,
      this.avatar,
      this.currentAddress});

  factory DataList.fromJson(Map<String, dynamic> json) {
    return DataList(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      vehicleNumber: json['vehicle_number'],
      avatar: json['avatar'],
      currentAddress: json['current_address'],
    );
  }
}
