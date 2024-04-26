// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/dao/datasource_contract/auth_datasource/auth_datasource.dart'
    as _i4;
import '../../data/dao/datasource_contract/brands_datasource/brands_datasource.dart'
    as _i9;
import '../../data/dao/datasource_contract/categories_datasource/category_data_source.dart'
    as _i13;
import '../../data/dao/datasource_contract/products_datasource/product_datasource.dart'
    as _i19;
import '../../data/dao/datasource_contract/subcategory_datasouce/subcategory_datasource.dart'
    as _i27;
import '../../data/dao/datasource_impl/auth_datasource_impl/auth_datasource_impl.dart'
    as _i5;
import '../../data/dao/datasource_impl/brands_datasource_impl/brands_datasource_impl.dart'
    as _i10;
import '../../data/dao/datasource_impl/categories_datasource_impl/category_datasource_impl.dart'
    as _i14;
import '../../data/dao/datasource_impl/products_datasource_impl/product_datasource_impl.dart'
    as _i20;
import '../../data/dao/datasource_impl/subcategory_datasouce_impl/subcategory_datasource_impl.dart'
    as _i28;
import '../../data/repository_impl/auth/auth_repo_impl.dart' as _i7;
import '../../data/repository_impl/brands/brands_repo_impl.dart' as _i12;
import '../../data/repository_impl/category/category_repo_impl.dart' as _i16;
import '../../data/repository_impl/products/product_repo_impl.dart' as _i22;
import '../../data/repository_impl/subcategory/subcategory_repo_impl.dart'
    as _i30;
import '../../domain/repository_contract/auth/auth_repo.dart' as _i6;
import '../../domain/repository_contract/brands/brands_repo.dart' as _i11;
import '../../domain/repository_contract/category/category_repo.dart' as _i15;
import '../../domain/repository_contract/products/products_repo.dart' as _i21;
import '../../domain/repository_contract/subcategory/subcategory_repo.dart'
    as _i29;
import '../../domain/usecases/auth/signin_auth_use_case.dart' as _i23;
import '../../domain/usecases/auth/signup_auth_use_case.dart' as _i25;
import '../../domain/usecases/brands/get_brands_usecase.dart' as _i17;
import '../../domain/usecases/category/get_category_usecase.dart' as _i18;
import '../../domain/usecases/products/get_most_selling_product_use_case.dart'
    as _i31;
import '../../domain/usecases/subcategory/subcategort_use_case.dart' as _i32;
import '../../presentation/auth_screens/login_screen/viewmodel/signin_view_model_cubit.dart'
    as _i24;
import '../../presentation/auth_screens/register_screen/viewmodel/signup_viewmodel_cubit.dart'
    as _i26;
import '../../presentation/auth_screens/viewmodel/auth_screens_cubit.dart'
    as _i8;
import '../../presentation/home/tabs/categories_tab/viewmodel/categories_tab_view_model_cubit.dart'
    as _i34;
import '../../presentation/home/tabs/home_tab/viewmodel/home_tab_viewmodel.dart'
    as _i33;
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
    gh.factory<_i4.AuthDataSource>(
        () => _i5.AuthDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i6.AuthRepo>(() => _i7.AuthRepoImpl(gh<_i4.AuthDataSource>()));
    gh.factory<_i8.AuthScreensCubit>(() => _i8.AuthScreensCubit());
    gh.factory<_i9.BrandsDataSource>(
        () => _i10.BrandsDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i11.BrandsRepo>(
        () => _i12.BrandsRepoImpl(gh<_i9.BrandsDataSource>()));
    gh.factory<_i13.CategoriesDataSourceContract>(
        () => _i14.CategoriesDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i15.CategoryRepository>(() =>
        _i16.CategoryRepositoryImpl(gh<_i13.CategoriesDataSourceContract>()));
    gh.factory<_i17.GetBrandsUseCase>(
        () => _i17.GetBrandsUseCase(gh<_i11.BrandsRepo>()));
    gh.factory<_i18.GetCategoryUseCase>(
        () => _i18.GetCategoryUseCase(gh<_i15.CategoryRepository>()));
    gh.factory<_i19.ProductDataSource>(
        () => _i20.ProductDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i21.ProductsRepo>(
        () => _i22.ProductRepoImpl(gh<_i19.ProductDataSource>()));
    gh.factory<_i23.SignInAuthUseCase>(
        () => _i23.SignInAuthUseCase(gh<_i6.AuthRepo>()));
    gh.factory<_i24.SignInViewModelCubit>(
        () => _i24.SignInViewModelCubit(gh<_i23.SignInAuthUseCase>()));
    gh.factory<_i25.SignUpAuthUseCase>(
        () => _i25.SignUpAuthUseCase(gh<_i6.AuthRepo>()));
    gh.factory<_i26.SignupViewModelCubit>(
        () => _i26.SignupViewModelCubit(gh<_i25.SignUpAuthUseCase>()));
    gh.factory<_i27.SubCategoryDataSource>(
        () => _i28.SubCategoryDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i29.SubCategoryRepository>(
        () => _i30.SubCategoryRepoImpl(gh<_i27.SubCategoryDataSource>()));
    gh.factory<_i31.GetMostSellingProductsUseCase>(
        () => _i31.GetMostSellingProductsUseCase(gh<_i21.ProductsRepo>()));
    gh.factory<_i32.GetSubCategoryUseCase>(
        () => _i32.GetSubCategoryUseCase(gh<_i29.SubCategoryRepository>()));
    gh.factory<_i33.HomeTabViewModel>(() => _i33.HomeTabViewModel(
          gh<_i18.GetCategoryUseCase>(),
          gh<_i17.GetBrandsUseCase>(),
          gh<_i31.GetMostSellingProductsUseCase>(),
        ));
    gh.factory<_i34.CategoriesTabViewModelCubit>(
        () => _i34.CategoriesTabViewModelCubit(
              gh<_i18.GetCategoryUseCase>(),
              gh<_i32.GetSubCategoryUseCase>(),
            ));
    return this;
  }
}
