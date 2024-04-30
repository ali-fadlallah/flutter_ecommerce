import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/features/splash_screen/presentation/manager/splash_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/local/shared_preference_helper.dart';
import '../../../../core/utils/routes/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SplashScreenViewModel().delay().then((_) {
      // Navigate to your next screen after delay
      SharedPreferenceHelper.getToken().isEmpty
          ? Navigator.pushNamedAndRemoveUntil(context, RoutesManager.loginRouteName, (route) => false)
          : Navigator.pushNamedAndRemoveUntil(context, RoutesManager.homeRouteName, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          )
        ],
      ),
    );
  }
}
