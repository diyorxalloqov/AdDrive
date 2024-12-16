import 'package:hive/hive.dart';

part 'user_model.g.dart';
@HiveType(typeId: 3)
class User {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? phone;

  @HiveField(3)
  dynamic phoneVerifyToken;

  @HiveField(4)
  int? isPhoneVerified;

  @HiveField(5)
  dynamic phoneVerifiedAt;

  @HiveField(6)
  dynamic phoneVerifyExpire;

  @HiveField(7)
  String? email;

  @HiveField(8)
  dynamic emailVerifyToken;

  @HiveField(9)
  int? isEmailVerified;

  @HiveField(10)
  dynamic emailVerifiedAt;

  @HiveField(11)
  dynamic emailVerifyExpire;

  @HiveField(12)
  dynamic avatarId;

  @HiveField(13)
  String? type;

  @HiveField(14)
  int? statusId;

  @HiveField(15)
  int? isBanned;

  @HiveField(16)
  dynamic bannedAt;

  @HiveField(17)
  dynamic unbannedAt;

  @HiveField(18)
  dynamic lastLoginAt;

  @HiveField(19)
  dynamic lastLogoutAt;

  @HiveField(20)
  dynamic lastLoginIp;

  @HiveField(21)
  int? loginAccess;

  @HiveField(22)
  dynamic deletedAt;

  @HiveField(23)
  DateTime? createdAt;

  @HiveField(24)
  DateTime? updatedAt;

  @HiveField(25)
  String? avatar;

  @HiveField(26)
  String? accessToken;


  User(
      { this.id,
      this.name,
      this.phone,
      this.phoneVerifyToken,
      this.isPhoneVerified,
      this.phoneVerifiedAt,
      this.phoneVerifyExpire,
      this.email,
      this.emailVerifyToken,
      this.isEmailVerified,
      this.emailVerifiedAt,
      this.emailVerifyExpire,
      this.avatarId,
      this.type,
      this.statusId,
      this.isBanned,
      this.bannedAt,
      this.unbannedAt,
      this.lastLoginAt,
      this.lastLogoutAt,
      this.lastLoginIp,
      this.loginAccess,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.avatar,
      this.accessToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      phoneVerifyToken: json["phone_verify_token"],
      isPhoneVerified: json["is_phone_verified"],
      phoneVerifiedAt: json["phone_verified_at"],
      phoneVerifyExpire: json["phone_verify_expire"],
      email: json["email"],
      emailVerifyToken: json["email_verify_token"],
      isEmailVerified: json["is_email_verified"],
      emailVerifiedAt: json["email_verified_at"],
      emailVerifyExpire: json["email_verify_expire"],
      avatarId: json["avatar_id"],
      type: json["type"],
      statusId: json["status_id"],
      isBanned: json["is_banned"],
      bannedAt: json["banned_at"],
      unbannedAt: json["unbanned_at"],
      lastLoginAt: json["last_login_at"],
      lastLogoutAt: json["last_logout_at"],
      lastLoginIp: json["last_login_ip"],
      loginAccess: json["login_access"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      avatar: json['avatar'],
      accessToken: json['token'],
    );
  }
}
