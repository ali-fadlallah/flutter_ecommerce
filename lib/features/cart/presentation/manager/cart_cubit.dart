import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/CartResponseEntity.dart';
import '../../domain/use_cases/delete_cart_use_case.dart';
import '../../domain/use_cases/get_cart_use_case.dart';
import '../../domain/use_cases/update_cart_use_case.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  // AddToCartUseCase addToCartUseCase;

  GetCartUseCase getCartUseCase;
  UpdateCartUseCase updateCartUseCase;
  DeleteCartUseCase deleteCartUseCase;

  @factoryMethod
  CartCubit(this.getCartUseCase, this.updateCartUseCase, this.deleteCartUseCase) : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  // late CartResponseEntity cartResponse;

  getCart() async {
    emit(CartOnLoading());
    var result = await getCartUseCase.call();
    result?.fold((cartResponseEntity) {
      emit(GetCartOnSuccess(cartResponseEntity));
      // cartResponse = cartResponseEntity;
    }, (errorMsg) {
      emit(CartOnError(errorMsg));
    });
  }

  updateCart({required String productId, required String count}) async {
    emit(UpdateCountLoadingState());
    var result = await updateCartUseCase.call(productId: productId, count: count);
    result?.fold((cartResponseEntity) {
      emit(GetCartOnSuccess(cartResponseEntity));
    }, (errorMsg) {
      emit(UpdateCountErrorState(errorMsg));
    });
  }

  deleteItemCart({required String productId}) async {
    emit(DeleteItemLoadingState());
    var result = await deleteCartUseCase.call(productId: productId);
    result?.fold((cartResponseEntity) {
      emit(GetCartOnSuccess(cartResponseEntity));
    }, (errorMsg) {
      print(errorMsg);
      emit(DeleteItemErrorState(errorMsg));
    });
  }
}
