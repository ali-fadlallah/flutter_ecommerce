import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CallbackFunction = void Function();

class CustomAuthButton extends StatelessWidget {
  final String buttonTitle;
  final CallbackFunction onItemPressed;
  const CustomAuthButton({Key? key, required this.buttonTitle, required this.onItemPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65.h,
      child: ElevatedButton(
        onPressed: onItemPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            )),
        child: Text(buttonTitle, style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
