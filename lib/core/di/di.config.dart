// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/dao/datasource_contract/brands_datasource/brands_datasource.dart'
    as _i4;
import '../../data/dao/datasource_contract/categories_datasource/category_data_source.dart'
    as _i8;
import '../../data/dao/datasource_contract/products_datasource/product_datasource.dart'
    as _i14;
import '../../data/dao/datasource_contract/subcategory_datasouce/subcategory_datasource.dart'
    as _i18;
import '../../data/dao/datasource_impl/brands_datasource_impl/brands_datasource_impl.dart'
    as _i5;
import '../../data/dao/datasource_impl/categories_datasource_impl/category_datasource_impl.dart'
    as _i9;
import '../../data/dao/datasource_impl/products_datasource_impl/product_datasource_impl.dart'
    as _i15;
import '../../data/dao/datasource_impl/subcategory_datasouce_impl/subcategory_datasource_impl.dart'
    as _i19;
import '../../data/repository_impl/brands/brands_repo_impl.dart' as _i7;
import '../../data/repository_impl/category/category_repo_impl.dart' as _i11;
import '../../data/repository_impl/products/product_repo_impl.dart' as _i17;
import '../../data/repository_impl/subcategory/subcategory_repo_impl.dart'
    as _i21;
import '../../domain/repository_contract/brands/brands_repo.dart' as _i6;
import '../../domain/repository_contract/category/category_repo.dart' as _i10;
import '../../domain/repository_contract/products/products_repo.dart' as _i16;
import '../../domain/repository_contract/subcategory/subcategory_repo.dart'
    as _i20;
import '../../domain/usecases/brands/get_brands_usecase.dart' as _i12;
import '../../domain/usecases/category/get_category_usecase.dart' as _i13;
import '../../domain/usecases/products/get_most_selling_product_use_case.dart'
    as _i22;
import '../../domain/usecases/subcategory/subcategort_use_case.dart' as _i23;
import '../../presentation/home/tabs/categories_tab/viewmodel/categories_tab_view_model_cubit.dart'
    as _i25;
import '../../presentation/home/tabs/home_tab/viewmodel/home_tab_viewmodel.dart'
    as _i24;
import '../api/api_manager.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ApiManager>(() => _i3.ApiManager());
    gh.factory<_i4.BrandsDataSource>(
        () => _i5.BrandsDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i6.BrandsRepo>(
        () => _i7.BrandsRepoImpl(gh<_i4.BrandsDataSource>()));
    gh.factory<_i8.CategoriesDataSourceContract>(
        () => _i9.CategoriesDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i10.CategoryRepository>(() =>
        _i11.CategoryRepositoryImpl(gh<_i8.CategoriesDataSourceContract>()));
    gh.factory<_i12.GetBrandsUseCase>(
        () => _i12.GetBrandsUseCase(gh<_i6.BrandsRepo>()));
    gh.factory<_i13.GetCategoryUseCase>(
        () => _i13.GetCategoryUseCase(gh<_i10.CategoryRepository>()));
    gh.factory<_i14.ProductDataSource>(
        () => _i15.ProductDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i16.ProductsRepo>(
        () => _i17.ProductRepoImpl(gh<_i14.ProductDataSource>()));
    gh.factory<_i18.SubCategoryDataSource>(
        () => _i19.SubCategoryDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i20.SubCategoryRepository>(
        () => _i21.SubCategoryRepoImpl(gh<_i18.SubCategoryDataSource>()));
    gh.factory<_i22.GetMostSellingProductsUseCase>(
        () => _i22.GetMostSellingProductsUseCase(gh<_i16.ProductsRepo>()));
    gh.factory<_i23.GetSubCategoryUseCase>(
        () => _i23.GetSubCategoryUseCase(gh<_i20.SubCategoryRepository>()));
    gh.factory<_i24.HomeTabViewModel>(() => _i24.HomeTabViewModel(
          gh<_i13.GetCategoryUseCase>(),
          gh<_i12.GetBrandsUseCase>(),
          gh<_i22.GetMostSellingProductsUseCase>(),
        ));
    gh.factory<_i25.CategoriesTabViewModelCubit>(
        () => _i25.CategoriesTabViewModelCubit(
              gh<_i13.GetCategoryUseCase>(),
              gh<_i23.GetSubCategoryUseCase>(),
            ));
    return this;
  }
}
