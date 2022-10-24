import 'package:firebase_auth/firebase_auth.dart';

class CustomAuthResult{
  String? errorMessage;
  User? user;

  CustomAuthResult({this.errorMessage, this.user});

}