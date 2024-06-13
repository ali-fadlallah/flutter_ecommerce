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
    as _i5;
import '../../features/authentication/data/dao/datasource_impl/auth_datasource_impl.dart'
    as _i6;
import '../../features/authentication/data/repositories_impl/auth_repo_impl.dart'
    as _i8;
import '../../features/authentication/data/services/AppleSignInHelper.dart'
    as _i4;
import '../../features/authentication/data/services/GoogleSignInHelper.dart'
    as _i26;
import '../../features/authentication/domain/repositories_contract/auth_repo.dart'
    as _i7;
import '../../features/authentication/domain/use_cases/signin_auth_use_case.dart'
    as _i36;
import '../../features/authentication/domain/use_cases/signup_auth_use_case.dart'
    as _i38;
import '../../features/authentication/presentation/manager/sign_in/signin_view_model_cubit.dart'
    as _i37;
import '../../features/authentication/presentation/manager/sign_up/signup_viewmodel_cubit.dart'
    as _i39;
import '../../features/cart/data/dao/datasource_contract/cart_datasource.dart'
    as _i13;
import '../../features/cart/data/dao/datasource_impl/cart_datasource_impl.dart'
    as _i14;
import '../../features/cart/data/repositories_impl/cart_repo_impl.dart' as _i16;
import '../../features/cart/domain/repositories_contract/cart_repo_datasource.dart'
    as _i15;
import '../../features/cart/domain/use_cases/Add_to_cart_UseCase.dart' as _i50;
import '../../features/cart/domain/use_cases/clear_cart_use_case.dart' as _i21;
import '../../features/cart/domain/use_cases/delete_cart_use_case.dart' as _i22;
import '../../features/cart/domain/use_cases/get_cart_use_case.dart' as _i24;
import '../../features/cart/domain/use_cases/update_cart_use_case.dart' as _i44;
import '../../features/cart/presentation/manager/cart_cubit.dart' as _i52;
import '../../features/categories/data/dao/datasource_contract/category_data_source.dart'
    as _i17;
import '../../features/categories/data/dao/datasource_impl/category_datasource_impl.dart'
    as _i18;
import '../../features/categories/data/repositories_impl/category_repo_impl.dart'
    as _i20;
import '../../features/categories/domain/repositories_contract/category_repo.dart'
    as _i19;
import '../../features/categories/domain/use_cases/get_category_usecase.dart'
    as _i25;
import '../../features/categories/presentation/manager/categories_tab_view_model_cubit.dart'
    as _i60;
import '../../features/home/data/dao/datasource_contract/brands_datasource/brands_datasource.dart'
    as _i9;
import '../../features/home/data/dao/datasource_contract/products_datasource/product_datasource.dart'
    as _i28;
import '../../features/home/data/dao/datasource_contract/subcategory_datasouce/subcategory_datasource.dart'
    as _i40;
import '../../features/home/data/dao/datasource_impl/brands_datasource_impl/brands_datasource_impl.dart'
    as _i10;
import '../../features/home/data/dao/datasource_impl/products_datasource_impl/product_datasource_impl.dart'
    as _i29;
import '../../features/home/data/dao/datasource_impl/subcategory_datasouce_impl/subcategory_datasource_impl.dart'
    as _i41;
import '../../features/home/data/repositories_impl/brands/brands_repo_impl.dart'
    as _i12;
import '../../features/home/data/repositories_impl/products/product_repo_impl.dart'
    as _i31;
import '../../features/home/data/repositories_impl/subcategory/subcategory_repo_impl.dart'
    as _i43;
import '../../features/home/domain/repositories_contract/brands/brands_repo.dart'
    as _i11;
import '../../features/home/domain/repositories_contract/products/products_repo.dart'
    as _i30;
import '../../features/home/domain/repositories_contract/subcategory/subcategory_repo.dart'
    as _i42;
import '../../features/home/domain/use_cases/brands/get_brands_usecase.dart'
    as _i23;
import '../../features/home/domain/use_cases/products/get_most_selling_product_use_case.dart'
    as _i53;
import '../../features/home/domain/use_cases/subcategory/subcategort_use_case.dart'
    as _i55;
import '../../features/home/presentation/manager/home_tab_view_model.dart'
    as _i27;
import '../../features/home/presentation/manager/home_viewmodel.dart' as _i57;
import '../../features/profile/data/dao/datasource_contract/profile_datasource.dart'
    as _i32;
import '../../features/profile/data/dao/datasource_impl/profile_datasource_impl.dart'
    as _i33;
import '../../features/profile/data/repositories_impl/profile_repo_impl.dart'
    as _i35;
import '../../features/profile/domain/repositories_contract/profile_repo.dart'
    as _i34;
import '../../features/profile/domain/use_cases/get_profile_data_use_case.dart'
    as _i54;
import '../../features/profile/domain/use_cases/update_profile_data_use_case.dart'
    as _i45;
import '../../features/profile/presentation/manager/profile_view_model_cubit.dart'
    as _i58;
import '../../features/wishlist/data/dao/datasource_contract/wish_list_data_souce.dart'
    as _i46;
import '../../features/wishlist/data/dao/datasource_impl/wish_list_data_souce_impl.dart'
    as _i47;
import '../../features/wishlist/data/repositories_impl/wish_list_repo_impl.dart'
    as _i49;
import '../../features/wishlist/domain/repositories_contract/wish_list_repo.dart'
    as _i48;
import '../../features/wishlist/domain/use_cases/add_to_wish_list_use_case.dart'
    as _i51;
import '../../features/wishlist/domain/use_cases/get_wish_list_use_case.dart'
    as _i56;
import '../../features/wishlist/presentation/manager/wish_list_cubit.dart'
    as _i59;
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
    gh.factory<_i4.AppleSignInHelper>(() => _i4.AppleSignInHelper());
    gh.factory<_i5.AuthDataSource>(
        () => _i6.AuthDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i7.AuthRepo>(() => _i8.AuthRepoImpl(gh<_i5.AuthDataSource>()));
    gh.factory<_i9.BrandsDataSource>(
        () => _i10.BrandsDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i11.BrandsRepo>(
        () => _i12.BrandsRepoImpl(gh<_i9.BrandsDataSource>()));
    gh.factory<_i13.CartDataSource>(
        () => _i14.CartDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i15.CartRepoDataSource>(
        () => _i16.CartRepoImpl(gh<_i13.CartDataSource>()));
    gh.factory<_i17.CategoriesDataSourceContract>(
        () => _i18.CategoriesDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i19.CategoryRepository>(() =>
        _i20.CategoryRepositoryImpl(gh<_i17.CategoriesDataSourceContract>()));
    gh.factory<_i21.ClearCartUseCase>(
        () => _i21.ClearCartUseCase(gh<_i15.CartRepoDataSource>()));
    gh.factory<_i22.DeleteCartUseCase>(
        () => _i22.DeleteCartUseCase(gh<_i15.CartRepoDataSource>()));
    gh.factory<_i23.GetBrandsUseCase>(
        () => _i23.GetBrandsUseCase(gh<_i11.BrandsRepo>()));
    gh.factory<_i24.GetCartUseCase>(
        () => _i24.GetCartUseCase(gh<_i15.CartRepoDataSource>()));
    gh.factory<_i25.GetCategoryUseCase>(
        () => _i25.GetCategoryUseCase(gh<_i19.CategoryRepository>()));
    gh.factory<_i26.GoogleSignInHelper>(() => _i26.GoogleSignInHelper());
    gh.factory<_i27.HomeTabViewModel>(() => _i27.HomeTabViewModel());
    gh.factory<_i28.ProductDataSource>(
        () => _i29.ProductDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i30.ProductsRepo>(
        () => _i31.ProductRepoImpl(gh<_i28.ProductDataSource>()));
    gh.factory<_i32.ProfileDataSource>(
        () => _i33.ProfileDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i34.ProfileRepo>(
        () => _i35.ProfileRepoImpl(gh<_i32.ProfileDataSource>()));
    gh.factory<_i36.SignInAuthUseCase>(
        () => _i36.SignInAuthUseCase(gh<_i7.AuthRepo>()));
    gh.factory<_i37.SignInViewModelCubit>(() => _i37.SignInViewModelCubit(
          gh<_i36.SignInAuthUseCase>(),
          gh<_i26.GoogleSignInHelper>(),
          gh<_i4.AppleSignInHelper>(),
        ));
    gh.factory<_i38.SignUpAuthUseCase>(
        () => _i38.SignUpAuthUseCase(gh<_i7.AuthRepo>()));
    gh.factory<_i39.SignupViewModelCubit>(
        () => _i39.SignupViewModelCubit(gh<_i38.SignUpAuthUseCase>()));
    gh.factory<_i40.SubCategoryDataSource>(
        () => _i41.SubCategoryDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i42.SubCategoryRepository>(
        () => _i43.SubCategoryRepoImpl(gh<_i40.SubCategoryDataSource>()));
    gh.factory<_i44.UpdateCartUseCase>(
        () => _i44.UpdateCartUseCase(gh<_i15.CartRepoDataSource>()));
    gh.factory<_i45.UpdateProfileDataUseCase>(
        () => _i45.UpdateProfileDataUseCase(gh<_i34.ProfileRepo>()));
    gh.factory<_i46.WishListDataSource>(
        () => _i47.WishListDataSourceImpl(gh<_i3.ApiManager>()));
    gh.factory<_i48.WishListRepo>(
        () => _i49.WishListRepoImpl(gh<_i46.WishListDataSource>()));
    gh.factory<_i50.AddToCartUseCase>(
        () => _i50.AddToCartUseCase(gh<_i15.CartRepoDataSource>()));
    gh.factory<_i51.AddToWishListUseCase>(
        () => _i51.AddToWishListUseCase(gh<_i48.WishListRepo>()));
    gh.factory<_i52.CartCubit>(() => _i52.CartCubit(
          gh<_i24.GetCartUseCase>(),
          gh<_i44.UpdateCartUseCase>(),
          gh<_i22.DeleteCartUseCase>(),
          gh<_i21.ClearCartUseCase>(),
        ));
    gh.factory<_i53.GetMostSellingProductsUseCase>(
        () => _i53.GetMostSellingProductsUseCase(gh<_i30.ProductsRepo>()));
    gh.factory<_i54.GetProfileDataUseCase>(
        () => _i54.GetProfileDataUseCase(gh<_i34.ProfileRepo>()));
    gh.factory<_i55.GetSubCategoryUseCase>(
        () => _i55.GetSubCategoryUseCase(gh<_i42.SubCategoryRepository>()));
    gh.factory<_i56.GetWishListUseCase>(
        () => _i56.GetWishListUseCase(gh<_i48.WishListRepo>()));
    gh.factory<_i57.HomeViewModel>(() => _i57.HomeViewModel(
          gh<_i25.GetCategoryUseCase>(),
          gh<_i23.GetBrandsUseCase>(),
          gh<_i53.GetMostSellingProductsUseCase>(),
          gh<_i50.AddToCartUseCase>(),
          gh<_i24.GetCartUseCase>(),
        ));
    gh.factory<_i58.ProfileViewModelCubit>(() => _i58.ProfileViewModelCubit(
          gh<_i54.GetProfileDataUseCase>(),
          gh<_i45.UpdateProfileDataUseCase>(),
        ));
    gh.factory<_i59.WishListCubit>(() => _i59.WishListCubit(
          gh<_i51.AddToWishListUseCase>(),
          gh<_i56.GetWishListUseCase>(),
        ));
    gh.factory<_i60.CategoriesTabViewModelCubit>(
        () => _i60.CategoriesTabViewModelCubit(
              gh<_i25.GetCategoryUseCase>(),
              gh<_i55.GetSubCategoryUseCase>(),
            ));
    return this;
  }
}
