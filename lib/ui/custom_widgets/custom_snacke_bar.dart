import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {int duration = 4000}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(milliseconds: duration),
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
