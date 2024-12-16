import 'package:flutter_texi_tracker/model/hive_model/user_model.dart';

SignupModel signupResponseFromJson(json) => SignupModel.fromJson(json);

class SignupModel {
  SignupModel({this.result, this.message, this.validation, this.user});

  bool? result;
  String? message;
  LaravelValidation? validation;
  User? user;

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
      result: json["result"],
      message: json["message"],
      user: json['user'] != null ? User.fromJson(json['user']) : null,

      validation: json["error"] != null && json["error"] != ''
          ? LaravelValidation.fromJson(json['error'])
          : LaravelValidation());
}

class LaravelValidation {
  final String? email;
  final String? phone;
  final String? password;
  final String? confirmPassword;

  LaravelValidation(
      {this.email, this.phone, this.password, this.confirmPassword});

  factory LaravelValidation.fromJson(Map<String, dynamic> json) {
    return LaravelValidation(
        email: json['email'] != null ? json['email'][0] : null,
        phone: json['phone'] != null ? json['phone'][0] : null,
        password: json['password'] != null ? json['password'][0] : null,
        confirmPassword: json['password_confirmation'] != null
            ? json['password_confirmation'][0]
            : null);
  }
}
