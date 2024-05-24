import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/features/wishlist/domain/use_cases/add_to_wish_list_use_case.dart';
import 'package:flutter_ecommerce_app/features/wishlist/presentation/manager/wish_list_state.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/get_wish_list_use_case.dart';

@injectable
class WishListCubit extends Cubit<WishListState> {
  AddToWishListUseCase addToWishListUseCase;

  GetWishListUseCase getWishListUseCase;

  @factoryMethod
  WishListCubit(this.addToWishListUseCase, this.getWishListUseCase) : super(WishListInitial());

  static WishListCubit get(context) => BlocProvider.of(context);

  addToWishList({required String productId}) async {
    emit(WishListOnLoading(productId));

    var result = await addToWishListUseCase.call(productId: productId);

    result?.fold((wishListEntity) {
      if (wishListEntity.statusMsg != null) {
        emit(WishListOnError(wishListEntity.message, productId));
      } else {
        emit(WishListOnSuccess(wishListEntity, productId));
      }
    }, (error) {
      emit(WishListOnError(error, productId));
    });
  }

  getWishList() async {
    emit(GetWishListOnLoading());
    var result = await getWishListUseCase.call();
    result?.fold((productEntity) {
      emit(GetWishListOnSuccess(productEntity));
    }, (errorMsg) {
      emit(GetWishListOnError(errorMsg));
    });
  }
}
