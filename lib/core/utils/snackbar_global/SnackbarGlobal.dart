import 'package:flutter/material.dart';

class SnackBarGlobal {
  static GlobalKey<ScaffoldMessengerState> key = GlobalKey<ScaffoldMessengerState>();

  static void showGreen(String message) {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
          content: Text(message),
        ),
      );
  }

  static showRed(String message) {
    if (key.currentState != null) {
      key.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(days: 1),
            backgroundColor: Colors.red,
            content: Text(message),
          ),
        );
    }
  }
}
