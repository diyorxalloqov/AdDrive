
import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  bool? result;
  String? message;
  dynamic error;
  User? user;

  RegisterResponseModel({
    this.result,
    this.message,
    this.error,
    this.user,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
    result: json["result"],
    message: json["message"],
    error: json["error"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "error": error,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  dynamic dateOfBirth;
  String? gender;
  dynamic phoneVerifyToken;
  int? isPhoneVerified;
  dynamic phoneVerifiedAt;
  dynamic phoneVerifyExpire;
  String? email;
  dynamic emailVerifyToken;
  int? isEmailVerified;
  dynamic emailVerifiedAt;
  dynamic emailVerifyExpire;
  int? balance;
  dynamic avatarId;
  String? type;
  int? statusId;
  int? isBanned;
  dynamic bannedAt;
  dynamic unbannedAt;
  dynamic lastLoginAt;
  dynamic lastLogoutAt;
  dynamic lastLoginIp;
  dynamic deviceToken;
  int? loginAccess;
  int? isMobile;
  int? isStop;
  dynamic socialId;
  dynamic socialType;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? avatar;
  String? token;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.phoneVerifyToken,
    this.isPhoneVerified,
    this.phoneVerifiedAt,
    this.phoneVerifyExpire,
    this.email,
    this.emailVerifyToken,
    this.isEmailVerified,
    this.emailVerifiedAt,
    this.emailVerifyExpire,
    this.balance,
    this.avatarId,
    this.type,
    this.statusId,
    this.isBanned,
    this.bannedAt,
    this.unbannedAt,
    this.lastLoginAt,
    this.lastLogoutAt,
    this.lastLoginIp,
    this.deviceToken,
    this.loginAccess,
    this.isMobile,
    this.isStop,
    this.socialId,
    this.socialType,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.avatar,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    dateOfBirth: json["date_of_birth"],
    gender: json["gender"],
    phoneVerifyToken: json["phone_verify_token"],
    isPhoneVerified: json["is_phone_verified"],
    phoneVerifiedAt: json["phone_verified_at"],
    phoneVerifyExpire: json["phone_verify_expire"],
    email: json["email"],
    emailVerifyToken: json["email_verify_token"],
    isEmailVerified: json["is_email_verified"],
    emailVerifiedAt: json["email_verified_at"],
    emailVerifyExpire: json["email_verify_expire"],
    balance: json["balance"],
    avatarId: json["avatar_id"],
    type: json["type"],
    statusId: json["status_id"],
    isBanned: json["is_banned"],
    bannedAt: json["banned_at"],
    unbannedAt: json["unbanned_at"],
    lastLoginAt: json["last_login_at"],
    lastLogoutAt: json["last_logout_at"],
    lastLoginIp: json["last_login_ip"],
    deviceToken: json["device_token"],
    loginAccess: json["login_access"],
    isMobile: json["is_mobile"],
    isStop: json["is_stop"],
    socialId: json["social_id"],
    socialType: json["social_type"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    name: json["name"],
    avatar: json["avatar"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "date_of_birth": dateOfBirth,
    "gender": gender,
    "phone_verify_token": phoneVerifyToken,
    "is_phone_verified": isPhoneVerified,
    "phone_verified_at": phoneVerifiedAt,
    "phone_verify_expire": phoneVerifyExpire,
    "email": email,
    "email_verify_token": emailVerifyToken,
    "is_email_verified": isEmailVerified,
    "email_verified_at": emailVerifiedAt,
    "email_verify_expire": emailVerifyExpire,
    "balance": balance,
    "avatar_id": avatarId,
    "type": type,
    "status_id": statusId,
    "is_banned": isBanned,
    "banned_at": bannedAt,
    "unbanned_at": unbannedAt,
    "last_login_at": lastLoginAt,
    "last_logout_at": lastLogoutAt,
    "last_login_ip": lastLoginIp,
    "device_token": deviceToken,
    "login_access": loginAccess,
    "is_mobile": isMobile,
    "is_stop": isStop,
    "social_id": socialId,
    "social_type": socialType,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "name": name,
    "avatar": avatar,
    "token": token,
  };
}
