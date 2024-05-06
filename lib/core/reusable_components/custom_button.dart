import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CallbackFunction = void Function();

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final CallbackFunction onItemPressed;
  final Color backgroundColor;
  double? height = 65.h;

  TextStyle? textStyle;
  CustomButton(
      {Key? key, required this.buttonTitle, this.height, required this.onItemPressed, this.backgroundColor = Colors.white, required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onItemPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            )),
        child: Text(buttonTitle, style: textStyle),
      ),
    );
  }
}
