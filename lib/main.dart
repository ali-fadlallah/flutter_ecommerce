import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/MyBlocObserver.dart';
import 'core/api/api_manager.dart';
import 'core/di/di.dart';
import 'myapp.dart';

void main() {
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  ApiManager.init();
  runApp(
    const MyApp(),
  );
}
