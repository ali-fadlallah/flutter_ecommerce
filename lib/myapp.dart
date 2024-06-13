import 'package:flutter_ecommerce_app/config/routes/routes.dart';

import 'config/app_theme/dark_theme.dart';
import 'config/app_theme/light_theme.dart';
import 'core/connectivity/wrapper/connectivity_wrapper.dart';
import 'core/global/global_imports.dart';
import 'core/utils/snackbar_global/SnackbarGlobal.dart';
import 'features/profile/presentation/manager/locale_cubit.dart';

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
            scaffoldMessengerKey: SnackBarGlobal.key,
            debugShowCheckedModeBanner: false,
            title: StringsManager.appName,
            theme: MyLightTheme.lightTheme,
            darkTheme: MyDarkTheme.darkTheme,
            initialRoute: PageRoutesNames.splashScreenRouteName,
            onGenerateRoute: Routes.onGenerateRoute,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
            builder: (context, child) => ConnectivityWrapper(
              child: child!,
            ),
          );
        },
      ),
    );
  }
}
