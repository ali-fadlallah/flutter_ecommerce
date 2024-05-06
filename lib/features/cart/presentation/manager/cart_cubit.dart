import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/CartResponseEntity.dart';

part 'cart_state.dart';

// @injectable
class CartCubit extends Cubit<CartState> {
  // AddToCartUseCase addToCartUseCase;

  CartCubit() : super(CartInitial());
  // static CartCubit get(context) => BlocProvider.of(context);
}
