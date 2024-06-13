import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/features/cart/domain/use_cases/get_cart_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../cart/domain/entities/CartResponseEntity.dart';
import '../../../cart/domain/use_cases/Add_to_cart_UseCase.dart';
import '../../../categories/domain/entities/CategoryEntity.dart';
import '../../../categories/domain/use_cases/get_category_usecase.dart';
import '../../../categories/presentation/screens/categories_tab.dart';
import '../../../profile/presentation/screens/profile_tab.dart';
import '../../../wishlist/presentation/screens/wishlist_tab.dart';
import '../../domain/entities/brands_entity/BrandsEntity.dart';
import '../../domain/entities/products_entity/ProductEntity.dart';
import '../../domain/use_cases/brands/get_brands_usecase.dart';
import '../../domain/use_cases/products/get_most_selling_product_use_case.dart';
import '../screens/home_tab.dart';

@injectable
class HomeViewModel extends Cubit<HomeInitiateState> {
  final List<Widget> widgetsList = [const HomeTab(), const CategoriesTab(), const WishListTab(), const ProfileTab()];

  static HomeViewModel get(context) => BlocProvider.of(context);
  AddToCartUseCase addToCartUseCase;
  GetCategoryUseCase getCategoryUseCase;
  GetBrandsUseCase getBrandsUseCase;

  GetCartUseCase getCartUseCase;
  GetMostSellingProductsUseCase getMostSellingProductsUseCase;
  @factoryMethod
  HomeViewModel(
    this.getCategoryUseCase,
    this.getBrandsUseCase,
    this.getMostSellingProductsUseCase,
    this.addToCartUseCase,
    this.getCartUseCase,
  ) : super(CategoriesOnLoading());

  getCategories() async {
    emit(CategoriesOnLoading());
    var result = await getCategoryUseCase.invoke();
    result?.fold((categories) {
      emit(CategoriesOnSuccess(categories));
    }, (error) {
      emit(CategoriesOnError(error));
    });
  }

  getBrands() async {
    emit(BrandsOnLoading());
    var result = await getBrandsUseCase.call();
    result?.fold((brandsList) {
      emit(BrandsOnSuccess(brandsList));
    }, (error) {
      emit(BrandsOnError(error));
    });
  }

  getMostSelling() async {
    emit(MostSellingOnLoading());
    var result = await getMostSellingProductsUseCase.call();

    result?.fold((productEntityList) {
      emit(MostSellingOnSuccess(productEntityList));
    }, (error) {
      emit(MostSellingOnError(error));
    });
  }

  int numOfItem = 0;
  addToCart({required String productId}) async {
    emit(CartOnLoading(productId));
    var result = await addToCartUseCase.call(productId: productId);
    result?.fold((cartResponseEntity) {
      numOfItem = cartResponseEntity.numOfCartItems?.toInt() ?? 0;
      emit(CartOnSuccess(cartResponseEntity, productId));
    }, (error) {
      emit(CartOnError(error, productId));
    });
  }

  int currentIndex = 0;

  setCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    emit(HomeTabChanged());
  }

  getCartCount() async {
    var result = await getCartUseCase.call();
    result?.fold((cartResponseEntity) {
      numOfItem = cartResponseEntity.numOfCartItems?.toInt() ?? 0;
      emit(GetCartOnSuccess(cartResponseEntity));
      // cartResponse = cartResponseEntity;
    }, (errorMsg) {
      emit(GetCartOnError(errorMsg));
    });
  }
}

sealed class HomeInitiateState {}

class HomeTabChanged extends HomeInitiateState {}

class EmptyCartOnSuccess extends HomeInitiateState {}

class UpdateCountLoadingState extends HomeInitiateState {
  final String? productId;

  UpdateCountLoadingState(this.productId);
}

class UpdateCountErrorState extends HomeInitiateState {
  final String? errorMsg;

  UpdateCountErrorState(this.errorMsg);
}

class HomeInitiate extends HomeInitiateState {}

class CategoriesOnLoading extends HomeInitiateState {}

class CategoriesOnSuccess extends HomeInitiateState {
  List<CategoryEntity> categoryList;

  CategoriesOnSuccess(this.categoryList);
}

class CategoriesOnError extends HomeInitiateState {
  String? errorMsg;

  CategoriesOnError(this.errorMsg);
}

class BrandsOnLoading extends HomeInitiateState {}

class BrandsOnSuccess extends HomeInitiateState {
  List<BrandsEntity> brandsList;

  BrandsOnSuccess(this.brandsList);
}

class BrandsOnError extends HomeInitiateState {
  String? errorMsg;

  BrandsOnError(this.errorMsg);
}

class MostSellingOnLoading extends HomeInitiateState {}

class MostSellingOnSuccess extends HomeInitiateState {
  List<ProductEntity> mostSellingList;

  MostSellingOnSuccess(this.mostSellingList);
}

class MostSellingOnError extends HomeInitiateState {
  String? errorMsg;

  MostSellingOnError(this.errorMsg);
}

final class CartOnLoading extends HomeInitiateState {
  String productId;

  CartOnLoading(this.productId);
}

final class CartOnError extends HomeInitiateState {
  final String? errorMsg;
  String productId;

  CartOnError(this.errorMsg, this.productId);
}

final class CartOnSuccess extends HomeInitiateState {
  final CartResponseEntity? cartResponseEntity;
  String productId;

  CartOnSuccess(this.cartResponseEntity, this.productId);
}

class GetCartOnSuccess extends HomeInitiateState {
  CartResponseEntity cartResponseEntity;

  GetCartOnSuccess(this.cartResponseEntity);
}

final class GetCartOnError extends HomeInitiateState {
  final String? errorMsg;

  GetCartOnError(this.errorMsg);
}
