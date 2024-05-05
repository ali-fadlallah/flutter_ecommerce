import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/di.dart';
import 'package:flutter_ecommerce_app/features/home/presentation/manager/home_viewmodel.dart';

import '../../../features/profile/presentation/manager/locale_cubit.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()..retrieveLanguage()),
    BlocProvider<HomeViewModel>(create: (context) => getIt()),
  ];
}
