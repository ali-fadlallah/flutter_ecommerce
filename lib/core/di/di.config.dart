// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentication/data/dao/datasource_contract/auth_datasource.dart'
    as _i4;
import '../../features/authentication/data/dao/datasource_impl/auth_datasource_impl.dart'
    as _i5;
import '../../features/authentication/data/repositories_impl/auth_repo_impl.dart'
    as _i7;
import '../../features/authentication/domain/repositories_contract/auth_repo.dart'
    as _i6;
import '../../features/authentication/domain/use_cases/signin_auth_use_case.dart'
    as _i31;
import '../../features/authentication/domain/use_cases/signup_auth_use_case.dart'
    as _i33;
import '../../features/authentication/presentation/manager/sign_in/signin_view_model_cubit.dart'
    as _i32;
import '../../features/authentication/presentation/manager/sign_up/signup_viewmodel_cubit.dart'
    as _i34;
import '../../features/cart/data/dao/datasource_contract/cart_datasource.dart'
    as _i12;
import '../../features/cart/data/dao/datasource_impl/cart_datasource_impl.dart'
    as _i13;
import '../../features/cart/data/repositories_impl/cart_repo_impl.dart' as _i15;
import '../../features/cart/domain/repositories_contract/cart_repo_datasource.dart'
    as _i14;
import '../../features/cart/domain/use_cases/Add_to_cart_UseCase.dart' as _i40;
import '../../features/categories/data/dao/datasource_contract/category_data_source.dart'
    as _i16;
import '../../features/categories/data/dao/datasource_impl/category_datasource_impl.dart'
    as _i17;
import '../../features/categories/data/repositories_impl/category_repo_impl.dart'
    as _i19;
import '../../features/categories/domain/repositories_contract/category_repo.dart'
    as _i18;
import '../../features/categories/domain/use_cases/get_category_usecase.dart'
    as _i21;
import '../../features/categories/presentation/manager/categories_tab_view_model_cubit.dart'
    as _i46;
import '../../features/home/data/dao/datasource_contract/brands_datasource/brands_datasource.dart'
    as _i8;
import '../../features/home/data/dao/datasource_contract/products_datasource/product_datasource.dart'
    as _i23;
import '../../features/home/data/dao/datasource_contract/subcategory_datasouce/subcategory_datasource.dart'
    as _i35;
import '../../features/home/data/dao/datasource_impl/brands_datasource_impl/brands_datasource_impl.dart'
    as _i9;
import '../../features/home/data/dao/datasource_impl/products_datasource_impl/product_datasource_impl.dart'
    as _i24;
import '../../features/home/data/dao/datasource_impl/subcategory_datasouce_impl/subcategory_datasource_impl.dart'
    as _i36;
import '../../features/home/data/repositories_impl/brands/brands_repo_impl.dart'
    as _i11;
import '../../features/home/data/repositories_impl/products/product_repo_impl.dart'
    as _i26;
import '../../features/home/data/repositories_impl/subcategory/subcategory_repo_impl.dart'
    as _i38;
import '../../features/home/domain/repositories_contract/brands/brands_repo.dart'
    as _i10;
import '../../features/home/domain/repositories_contract/products/products_repo.dart'
    as _i25;
import '../../features/home/domain/repositories_contract/subcategory/subcategory_repo.dart'
    as _i37;
import '../../features/home/domain/use_cases/brands/get_brands_usecase.dart'
    as _i20;
import '../../features/home/domain/use_cases/products/get_most_selling_product_use_case.dart'
    as _i41;
import '../../features/home/domain/use_cases/subcategory/subcategort_use_case.dart'
    as _i43;
import '../../features/home/presentation/manager/home_tab_view_model.dart'
    as _i22;
import '../../features/home/presentation/manager/home_viewmodel.dart' as _i44;
import '../../features/profile/data/dao/datasource_contract/profile_datasource.dart'
    as _i27;
import '../../features/profile/data/dao/datasource_impl/profile_datasource_impl.dart'
    as _i28;
import '../../features/profile/data/repositories_impl/profile_repo_impl.dart'
    as _i30;
import '../../features/profile/domain/repositories_contract/profile_repo.dart'
    as _i29;
import '../../features/profile/domain/use_cases/get_profile_data_use_case.dart'
    as _i42;
import '../../features/profile/domain/use_cases/update_profile_data_use_case.dart'
    as _i39;
import '../../features/profile/presentation/manager/profile_view_model_cubit.dart'
    as _i45;
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
    gh.factory<_i8.BrandsDataSource>(
        () => _i9.BrandsDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i10.BrandsRepo>(
        () => _i11.BrandsRepoImpl(gh<_i8.BrandsDataSource>()));
    gh.factory<_i12.CartDataSource>(
        () => _i13.CartDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i14.CartRepoDataSource>(
        () => _i15.CartRepoImpl(gh<_i12.CartDataSource>()));
    gh.factory<_i16.CategoriesDataSourceContract>(
        () => _i17.CategoriesDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i18.CategoryRepository>(() =>
        _i19.CategoryRepositoryImpl(gh<_i16.CategoriesDataSourceContract>()));
    gh.factory<_i20.GetBrandsUseCase>(
        () => _i20.GetBrandsUseCase(gh<_i10.BrandsRepo>()));
    gh.factory<_i21.GetCategoryUseCase>(
        () => _i21.GetCategoryUseCase(gh<_i18.CategoryRepository>()));
    gh.factory<_i22.HomeTabViewModel>(() => _i22.HomeTabViewModel());
    gh.factory<_i23.ProductDataSource>(
        () => _i24.ProductDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i25.ProductsRepo>(
        () => _i26.ProductRepoImpl(gh<_i23.ProductDataSource>()));
    gh.factory<_i27.ProfileDataSource>(
        () => _i28.ProfileDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i29.ProfileRepo>(
        () => _i30.ProfileRepoImpl(gh<_i27.ProfileDataSource>()));
    gh.factory<_i31.SignInAuthUseCase>(
        () => _i31.SignInAuthUseCase(gh<_i6.AuthRepo>()));
    gh.factory<_i32.SignInViewModelCubit>(
        () => _i32.SignInViewModelCubit(gh<_i31.SignInAuthUseCase>()));
    gh.factory<_i33.SignUpAuthUseCase>(
        () => _i33.SignUpAuthUseCase(gh<_i6.AuthRepo>()));
    gh.factory<_i34.SignupViewModelCubit>(
        () => _i34.SignupViewModelCubit(gh<_i33.SignUpAuthUseCase>()));
    gh.factory<_i35.SubCategoryDataSource>(
        () => _i36.SubCategoryDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i37.SubCategoryRepository>(
        () => _i38.SubCategoryRepoImpl(gh<_i35.SubCategoryDataSource>()));
    gh.factory<_i39.UpdateProfileDataUseCase>(
        () => _i39.UpdateProfileDataUseCase(gh<_i29.ProfileRepo>()));
    gh.factory<_i40.AddToCartUseCase>(
        () => _i40.AddToCartUseCase(gh<_i14.CartRepoDataSource>()));
    gh.factory<_i41.GetMostSellingProductsUseCase>(
        () => _i41.GetMostSellingProductsUseCase(gh<_i25.ProductsRepo>()));
    gh.factory<_i42.GetProfileDataUseCase>(
        () => _i42.GetProfileDataUseCase(gh<_i29.ProfileRepo>()));
    gh.factory<_i43.GetSubCategoryUseCase>(
        () => _i43.GetSubCategoryUseCase(gh<_i37.SubCategoryRepository>()));
    gh.factory<_i44.HomeViewModel>(() => _i44.HomeViewModel(
          gh<_i21.GetCategoryUseCase>(),
          gh<_i20.GetBrandsUseCase>(),
          gh<_i41.GetMostSellingProductsUseCase>(),
          gh<_i40.AddToCartUseCase>(),
        ));
    gh.factory<_i45.ProfileViewModelCubit>(() => _i45.ProfileViewModelCubit(
          gh<_i42.GetProfileDataUseCase>(),
          gh<_i39.UpdateProfileDataUseCase>(),
        ));
    gh.factory<_i46.CategoriesTabViewModelCubit>(
        () => _i46.CategoriesTabViewModelCubit(
              gh<_i21.GetCategoryUseCase>(),
              gh<_i43.GetSubCategoryUseCase>(),
            ));
    return this;
  }
}
