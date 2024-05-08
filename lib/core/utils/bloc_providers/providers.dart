import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/cart/presentation/manager/cart_cubit.dart';
import '../../../features/home/presentation/manager/home_viewmodel.dart';
import '../../../features/profile/presentation/manager/locale_cubit.dart';
import '../../di/di.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()..retrieveLanguage()),
    BlocProvider<HomeViewModel>(create: (context) => getIt()),
    BlocProvider<CartCubit>(create: (context) => getIt()),
  ];
}
