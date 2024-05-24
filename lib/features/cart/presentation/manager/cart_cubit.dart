import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/CartResponseEntity.dart';
import '../../domain/use_cases/clear_cart_use_case.dart';
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
  ClearCartUseCase clearCartUseCase;

  @factoryMethod
  CartCubit(this.getCartUseCase, this.updateCartUseCase, this.deleteCartUseCase, this.clearCartUseCase) : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  // late CartResponseEntity cartResponse;

  getCart() async {
    emit(CartScreenOnLoading());
    var result = await getCartUseCase.call();
    result?.fold((cartResponseEntity) {
      if (cartResponseEntity.statusMsg == 'fail' || cartResponseEntity.data?.products?.length == null || cartResponseEntity.numOfCartItems == 0) {
        emit(EmptyScreenCartSuccess());
      } else {
        emit(CartScreenOnSuccess(cartResponseEntity));
      }
    }, (errorMsg) {
      emit(CartScreenOnError(errorMsg));
    });
  }

  updateCart({required String productId, required String count}) async {
    emit(UpdateCountScreenLoadingState(productId));
    var result = await updateCartUseCase.call(productId: productId, count: count);
    result?.fold((cartResponseEntity) {
      if (cartResponseEntity.data!.products!.isEmpty) {
        emit(EmptyScreenCartSuccess());
      } else {
        emit(CartScreenOnSuccess(cartResponseEntity));
      }
    }, (errorMsg) {
      print(errorMsg);
      emit(UpdateCountErrorState(errorMsg));
    });
  }

  deleteItemCart({required String productId}) async {
    emit(DeleteItemLoadingState(productId));
    var result = await deleteCartUseCase.call(productId: productId);
    result?.fold((cartResponseEntity) {
      if (cartResponseEntity.data!.products!.isEmpty) {
        emit(EmptyScreenCartSuccess());
      } else {
        emit(CartScreenOnSuccess(cartResponseEntity));
      }
    }, (errorMsg) {
      emit(DeleteItemErrorState(errorMsg));
    });
  }

  clearCart() async {
    emit(ClearCartOnLoading());
    var result = await clearCartUseCase.call();
    result?.fold((cartResponseEntity) {
      if (cartResponseEntity.message == 'success') {
        emit(ClearCartOnSuccess());
      }
      //
    }, (errorMsg) {
      emit(DeleteItemErrorState(errorMsg));
    });
  }

  int current = 1;

  increase({required int theCurrentNumber}) {
    current = theCurrentNumber;
    current++;
    emit(CartScreenCountChanged(theCurrentNumber));
  }

  decrease({required int theCurrentNumber}) {
    current = theCurrentNumber;
    theCurrentNumber--;
    current = theCurrentNumber;
    emit(CartScreenCountChanged(theCurrentNumber));
  }
}
