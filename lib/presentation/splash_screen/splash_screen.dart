import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/core/utils/routes/routes_manager.dart';
import 'package:flutter_ecommerce_app/presentation/splash_screen/viewmodel/splash_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashScreenViewModel().delay().then((_) {
      // Navigate to your next screen after delay
      Navigator.pushReplacementNamed(context, RoutesManager.homeRouteName);
    });
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsManager.appBarLogo,
            width: 100.w,
            height: 100.h,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          )
        ],
      ),
    );
  }
}
