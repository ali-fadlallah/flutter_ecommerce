part of 'categories_tab_view_model_cubit.dart';

sealed class CategoriesTabViewModelState {}

final class CategoriesTabViewModelInitial extends CategoriesTabViewModelState {}

final class CategoriesTabViewModelOnLoading extends CategoriesTabViewModelState {}

final class CategoriesTabViewModelOnIndexChanged extends CategoriesTabViewModelState {}

final class CategoriesTabViewModelOnError extends CategoriesTabViewModelState {
  String? error;
  CategoriesTabViewModelOnError(this.error);
}

final class CategoriesTabViewModelOnSuccess extends CategoriesTabViewModelState {
  List<CategoryEntity> categoryEntityList;
  CategoriesTabViewModelOnSuccess(this.categoryEntityList);
}

final class SubCategoriesTabViewModelOnLoading extends CategoriesTabViewModelState {}

final class SubCategoriesTabViewModelOnError extends CategoriesTabViewModelState {
  String? error;
  SubCategoriesTabViewModelOnError(this.error);
}

final class SubCategoriesTabViewModelOnSuccess extends CategoriesTabViewModelState {
  List<SubcategoryEntity> subcategoryEntityList;
  SubCategoriesTabViewModelOnSuccess(this.subcategoryEntityList);
}
