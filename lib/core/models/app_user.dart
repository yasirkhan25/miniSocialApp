import 'package:flutter/material.dart';

class AppUser {
  String? appUserId;
  String? userName;
  String? userEmail;
  String? phoneNumber;
  String? address;
  String? password;
  String? confirmPassword;
  bool? isFirstLogin;
  String? profileImage;


  AppUser({
    this.appUserId,
    this.userEmail,
    this.userName,
    this.phoneNumber,
    this.address,
    this.password,
    this.confirmPassword,
    this.isFirstLogin,
    this.profileImage,

  });

  AppUser.fromJson(json, id) {
    this.appUserId = id;
    this.userName = json['userName'] ?? '';
    this.userEmail = json['userEmail'];
    this.phoneNumber = json['phoneNumber'] ?? '';
    this.address = json['address'] ?? '';
    this.password = json['password'] ?? '';
    this.confirmPassword = json['confirmPassword'] ?? '';
    this.isFirstLogin = json['isFirstLogin'] ?? '';
    this.profileImage = json['profileImage'];

  }

  toJson() {
    return {
      'appUserId': this.appUserId,
      'userName': this.userName,
      'userEmail': this.userEmail,
      'phoneNumber': this.phoneNumber,
      'address': this.address,
      'password': this.password,
      'confirmPassword': this.confirmPassword,
      'isFirstLogin': this.isFirstLogin,
      'profileImage': this.profileImage,
    };
  }
}
