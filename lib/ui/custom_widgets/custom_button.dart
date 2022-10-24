import 'package:flutter/material.dart';
import '../../core/contstant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  String text;

  CustomButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}