class DriverProfileModel {
  bool? success;
  Data? data;
  String? message;

  DriverProfileModel({this.success, this.data, this.message});

  DriverProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class Data {
  int? id;
  String? name;
  String? phone;
  String? email;
  int? avatarId;
  String? gender;
  dynamic balance;
  String? type;
  String? avatar;
  String? vehicleNumber;
  Driver? driver;
  Agreement? agreement;

  Data(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.avatarId,
      this.gender,
      this.balance,
      this.type,
      this.avatar,
      this.vehicleNumber,
      this.driver,
      this.agreement});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    avatarId = json["avatar_id"];
    gender = json['gender'];
    balance = json['balance'];
    type = json['type'];
    avatar = json['avatar'];
    vehicleNumber = json['vehicle_number'];
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    agreement = json['agreement'] != null
        ? Agreement.fromJson(json['agreement'])
        : null;
  }
}

class Driver {
  int? id;
  int? userId;
  String? phone;
  String? emergencyContact;
  String? drivingLicenceNumber;
  String? drivingLicenceExpiryDate;
  var isEngage;
  var drivingLicence;
  String? nidCard;
  String? currentAddress;

  Driver({this.id, this.userId, this.phone, this.emergencyContact, this.drivingLicenceNumber, this.drivingLicenceExpiryDate,
      this.isEngage, this.drivingLicence, this.nidCard, this.currentAddress});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    phone = json['phone'];
    emergencyContact = json['emergency_contact'];
    drivingLicenceNumber = json['driving_licence_number'];
    drivingLicenceExpiryDate = json['driving_licence_expiry_date'];
    isEngage = json['is_engage'];
    drivingLicence = json['driving_licence'];
    nidCard = json['nid_card'];
    currentAddress = json['current_address'];
  }
}

class Agreement {
  int? id;
  int? type;
  int? userId;
  int? amount;
  int? distance;
  int? totalCar;
  dynamic documents;
  String? startDate;
  String? endDate;

  Agreement(
      {this.id,
      this.type,
      this.userId,
      this.amount,
      this.distance,
      this.totalCar,
      this.documents,
      this.startDate,
      this.endDate});

  Agreement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    amount = json['amount'];
    distance = json['distance'];
    totalCar = json['total_car'];
    documents = json['documents'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }
}
