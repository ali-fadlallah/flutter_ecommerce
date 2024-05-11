import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/features/wishlist/presentation/manager/wish_list_cubit.dart';

import '../../../features/cart/presentation/manager/cart_cubit.dart';
import '../../../features/home/presentation/manager/home_viewmodel.dart';
import '../../../features/profile/presentation/manager/locale_cubit.dart';
import '../../di/di.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()..retrieveLanguage()),
    BlocProvider<HomeViewModel>(create: (_) => getIt()),
    BlocProvider<CartCubit>(create: (_) => getIt()),
    BlocProvider<WishListCubit>(create: (_) => getIt()),
  ];
}
