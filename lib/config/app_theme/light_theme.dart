import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce_app/core/utils/colors/colors_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLightTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsManager.primaryColor),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorsManager.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actionsIconTheme: IconThemeData(color: ColorsManager.primaryColor),
        centerTitle: true),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.secondaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.secondaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.secondaryColor,
      ),
    ),
  );
}
