import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:flutter_ecommerce_app/features/home/domain/entities/products_entity/ProductEntity.dart';
import 'package:flutter_ecommerce_app/features/product_details/presentation/screens/product_details.dart';

import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash_screen/presentation/screens/splash_screen.dart';
import 'page_routes_name.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRoutesNames.splashScreenRouteName:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case PageRoutesNames.homeRouteName:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case PageRoutesNames.loginRouteName:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case PageRoutesNames.registerRouteName:
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case PageRoutesNames.cartRouteName:
        return MaterialPageRoute(builder: (context) => CartScreen());
      case PageRoutesNames.productDetailsRouteName:
        return MaterialPageRoute(builder: (context) {
          final arg = settings.arguments as ProductEntity;
          return ProductDetails(
            productEntity: arg,
          );
        });
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text(StringsManager.noRouteFound),
            ),
          );
        });
    }
  }
}