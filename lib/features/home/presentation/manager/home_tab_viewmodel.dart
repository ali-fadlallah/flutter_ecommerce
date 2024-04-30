import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../categories/domain/entities/CategoryEntity.dart';
import '../../../categories/domain/use_cases/get_category_usecase.dart';
import '../../domain/entities/brands_entity/BrandsEntity.dart';
import '../../domain/entities/products_entity/ProductEntity.dart';
import '../../domain/use_cases/brands/get_brands_usecase.dart';
import '../../domain/use_cases/products/get_most_selling_product_use_case.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeInitiateState> {
  GetCategoryUseCase getCategoryUseCase;

  GetBrandsUseCase getBrandsUseCase;

  GetMostSellingProductsUseCase getMostSellingProductsUseCase;
  @factoryMethod
  HomeTabViewModel(this.getCategoryUseCase, this.getBrandsUseCase, this.getMostSellingProductsUseCase) : super(CategoriesOnLoading());

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
}

sealed class HomeInitiateState {}

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