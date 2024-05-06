import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final List<Widget> widgetsList = [HomeTab(), CategoriesTab(), WishListTab(), ProfileTab()];

  static HomeViewModel get(context) => BlocProvider.of(context);
  AddToCartUseCase addToCartUseCase;
  GetCategoryUseCase getCategoryUseCase;

  GetBrandsUseCase getBrandsUseCase;

  GetMostSellingProductsUseCase getMostSellingProductsUseCase;
  @factoryMethod
  HomeViewModel(this.getCategoryUseCase, this.getBrandsUseCase, this.getMostSellingProductsUseCase, this.addToCartUseCase)
      : super(CategoriesOnLoading());

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
      debugPrint('$numOfItem');
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
}

sealed class HomeInitiateState {}

class HomeTabChanged extends HomeInitiateState {}

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
