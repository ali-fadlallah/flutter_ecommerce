import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app/features/categories/domain/entities/CategoryEntity.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/use_cases/subcategory/subcategort_use_case.dart';
import '../../domain/use_cases/get_category_usecase.dart';
import 'categories_tab_view_model_state.dart';

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
