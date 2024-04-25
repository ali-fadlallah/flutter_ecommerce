import 'package:flutter/material.dart';

class MyCustomDialogs {
  static void showLoadingDialog({required BuildContext context, required String text}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }

  static void hideLoadingDialog({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessageDialog(
      {required BuildContext context,
      required String message,
      String? positiveTitle,
      void Function()? positiveClick,
      String? negativeTitle,
      void Function()? negativeClick}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          if (positiveTitle != null)
            TextButton(
              onPressed: () {
                positiveClick ?? ();
              },
              child: Text(positiveTitle),
            ),
          if (negativeTitle != null)
            TextButton(
              onPressed: () {
                negativeClick ?? ();
              },
              child: Text(negativeTitle),
            ),
        ],
      ),
    );
  }
}
