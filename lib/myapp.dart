import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/config/routes/page_routes_name.dart';
import 'package:flutter_ecommerce_app/config/routes/routes.dart';
import 'package:flutter_ecommerce_app/features/profile/presentation/manager/locale_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/app_theme/dark_theme.dart';
import 'config/app_theme/light_theme.dart';
import 'core/utils/strings/strings_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: StringsManager.appName,
              theme: MyLightTheme.lightTheme,
              darkTheme: MyDarkTheme.darkTheme,
              initialRoute: PageRoutesNames.splashScreenRouteName,
              onGenerateRoute: Routes.onGenerateRoute,
              // routes: {
              //   RoutesManager.homeRouteName: (context) => HomeScreen(),
              //   RoutesManager.splashScreenRouteName: (context) => SplashScreen(),
              //   RoutesManager.loginRouteName: (context) => LoginScreen(),
              //   RoutesManager.registerRouteName: (context) => RegisterScreen(),
              // },
              // localizationsDelegates: [
              //   AppLocalizations.delegate, // Add this line
              //   GlobalMaterialLocalizations.delegate,
              //   GlobalWidgetsLocalizations.delegate,
              //   GlobalCupertinoLocalizations.delegate,
              // ],
              // supportedLocales: [
              //   Locale('en'), // English
              //   Locale('ar'), // Arabic
              // ],
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.locale);
        },
      ),
    );
  }
}
