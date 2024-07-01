import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_drive/configuration/colors.dart';

class ToastUi {
  static void showToast(String status, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withAlpha(20),
      // backgroundColor: status == "success" ? AppColors.connectedUserColor : AppColors.secondary,
      textColor: Colors.black.withAlpha(200),
      fontSize: 16.0
    );
  }
}