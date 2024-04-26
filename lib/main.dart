import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/local/shared_preference_helper.dart';

import 'core/MyBlocObserver.dart';
import 'core/api/api_manager.dart';
import 'core/di/di.dart';
import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  ApiManager.init();
  await SharedPreferenceHelper.init();
  runApp(
    const MyApp(),
  );
}
