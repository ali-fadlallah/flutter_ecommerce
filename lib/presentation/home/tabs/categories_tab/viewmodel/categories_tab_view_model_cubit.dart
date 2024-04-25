import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app/domain/entities/category_entity/CategoryEntity.dart';
import 'package:flutter_ecommerce_app/domain/entities/products_entity/SubcategoryEntity.dart';
import 'package:flutter_ecommerce_app/domain/usecases/subcategory/subcategort_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/usecases/category/get_category_usecase.dart';

part 'categories_tab_view_model_state.dart';

@injectable
class CategoriesTabViewModelCubit extends Cubit<CategoriesTabViewModelState> {
  GetCategoryUseCase getCategoryUseCase;

  GetSubCategoryUseCase getSubCategoryUseCase;
  @factoryMethod
  CategoriesTabViewModelCubit(this.getCategoryUseCase, this.getSubCategoryUseCase) : super(CategoriesTabViewModelInitial());

  List<CategoryEntity> categoryList = [];

  getCategories() async {
    emit(CategoriesTabViewModelOnLoading());
    var result = await getCategoryUseCase.invoke();
    result?.fold((categoryEntityList) {
      categoryList = categoryEntityList;
      emit(CategoriesTabViewModelOnSuccess(categoryEntityList));
    }, (error) {
      emit(CategoriesTabViewModelOnError(error));
    });
  }

  int selectedIndex = 0;
  int getSelectedIndex(int newIndex) {
    selectedIndex = newIndex;
    emit(CategoriesTabViewModelOnIndexChanged());
    return selectedIndex;
  }

  getSpecificSubCategory(String categoryID) async {
    emit(SubCategoriesTabViewModelOnLoading());

    var result = await getSubCategoryUseCase.call(categoryID);

    result?.fold((subCategoryEntityList) {
      emit(SubCategoriesTabViewModelOnSuccess(subCategoryEntityList));
    }, (error) {
      emit(SubCategoriesTabViewModelOnError(error));
    });
  }
}
