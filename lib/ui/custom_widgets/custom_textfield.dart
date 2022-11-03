import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/contstant/color.dart';

class CustomTextField extends StatelessWidget {
  final onChanged;
  final validator;
  final hintText;
  final controller;
  final preFixIcon;
  bool obscureText;
  final textInputAction;
  final keyBoardType;
  IconButton? suffixIcon;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;

  CustomTextField({
    this.preFixIcon,
    this.suffixIcon,
    this.onChanged,
    this.controller,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
    this.keyBoardType,
    this.focusNode,
    this.onFieldSubmitted,

    EdgeInsets? contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 16),
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        obscuringCharacter: "*",
        cursorColor: primaryColor,
        decoration: InputDecoration(
          // border: InputBorder.none,
          filled: true,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          prefix: preFixIcon,
          suffixIcon: suffixIcon,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
