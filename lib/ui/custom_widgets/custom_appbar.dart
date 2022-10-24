import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar({
  final Widget? title,
  final Widget? leading,
  final Widget? action,
  bool?  automaticallyImplyLeading,
  double? toolBarHeight,
}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    //automaticallyImplyLeading: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(12),
      ),
    ),
    leading: leading,
    toolbarHeight: toolBarHeight,
    title: title,
    actions: [
      action ?? SizedBox(),
    ],
    automaticallyImplyLeading: automaticallyImplyLeading!,
  );
}
