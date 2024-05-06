import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/cart/presentation/screens/cart_screen.dart';

import '../../core/utils/routes/routes_manager.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash_screen/presentation/screens/splash_screen.dart';

class MyRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesManager.splashScreenRouteName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesManager.homeRouteName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RoutesManager.loginRouteName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RoutesManager.registerRouteName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case RoutesManager.cartRouteName:
        return MaterialPageRoute(builder: (_) => CartScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text(StringsManager.noRouteFound),
            ),
          );
        });
    }
  }
}
