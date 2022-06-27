import 'package:flutter/material.dart';

extension ScaffoldHelper on BuildContext? {
  void show({required String message, SnackBarBehavior? snackBarBehavior = SnackBarBehavior.fixed}) {
    if (this == null) {
      return;
    }

    ScaffoldMessenger.maybeOf(this!)
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        behavior: snackBarBehavior,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        duration: Duration(seconds: 2),
      ));
  }

  void showMainScreenSnack({required String message, SnackBarBehavior? snackBarBehavior = SnackBarBehavior.fixed}) {
    if (this == null) {
      return;
    }

    ScaffoldMessenger.maybeOf(this!)
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        padding: EdgeInsetsDirectional.only(bottom: AppBar().preferredSize.height * 0.85, top: 10),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ));
  }

}

