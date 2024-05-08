import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/assets/assets_manager.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/splash_screen/presentation/manager/splash_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/routes/page_routes_name.dart';
import '../../../../core/local/shared_preference_helper.dart';

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
      SharedPreferenceHelper.getData(key: StringsManager.keyToken) == null
          ? Navigator.pushNamedAndRemoveUntil(context, PageRoutesNames.loginRouteName, (route) => false)
          : Navigator.pushNamedAndRemoveUntil(context, PageRoutesNames.homeRouteName, (route) => false);
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
