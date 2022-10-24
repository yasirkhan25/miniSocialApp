import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final onChanged;
  final validator;
  final hintText;
  final controller;
  final preFixIcon;
  final sufFixIcon;
  bool obscureText;
  final textInputAction;
  final keyBoardType;
  IconButton? suffixIcon;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;

  CustomTextField({
    this.preFixIcon,
    this.sufFixIcon,
    this.onChanged,
    this.controller,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
    this.keyBoardType,
    this.suffixIcon,
    this.focusNode,
    this.onFieldSubmitted,

    EdgeInsets? contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Center(
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
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
            prefix: preFixIcon,
            suffixIcon: sufFixIcon,
          ),
        ),
      ),
    );
  }
}
