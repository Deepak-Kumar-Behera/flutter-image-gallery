import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HSnackBar {
  HSnackBar._privateConstructor();
  static final HSnackBar instance = HSnackBar._privateConstructor();

  void error(String message) {
    _show(message: message, backgroundColor: Colors.red.shade700);
  }

  void success(String message) {
    _show(message: message, backgroundColor: Colors.green.shade700);
  }

  void info(String message) {
    _show(message: message, backgroundColor: Colors.black87);
  }

  static Future<void> _show({required String message, required Color backgroundColor}) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 14,
    );
  }
}
