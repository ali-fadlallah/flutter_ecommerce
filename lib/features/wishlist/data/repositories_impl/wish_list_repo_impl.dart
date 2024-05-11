import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/home/domain/entities/products_entity/ProductEntity.dart';
import 'package:flutter_ecommerce_app/features/wishlist/data/dao/datasource_contract/wish_list_data_souce.dart';
import 'package:flutter_ecommerce_app/features/wishlist/domain/repositories_contract/wish_list_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../home/data/models/products_response/ProductModel.dart';
import '../../domain/entities/WishListEntity.dart';

@Injectable(as: WishListRepo)
class WishListRepoImpl extends WishListRepo {
  WishListDataSource wishListDataSource;

  @factoryMethod
  WishListRepoImpl(this.wishListDataSource);

  @override
  Future<Either<WishListEntity, String>?> addToWishList({required String productId}) async {
    var result = await wishListDataSource.addToWishList(productId: productId);

    return result?.fold((wishListResponse) {
      WishListEntity response = wishListResponse.toWishListEntity();

      return Left(response);
    }, (error) {
      return Right(error);
    });
  }

  @override
  Future<Either<List<ProductEntity>, String>?> getWishList() async {
    var result = await wishListDataSource.getWishList();

    return result?.fold((allWishListResponse) {
      List<ProductModel> productList = allWishListResponse.data ?? [];

      List<ProductEntity> productEntityList = productList.map((productModel) => productModel.toProductEntity()).toList();

      return Left(productEntityList);
    }, (error) {
      return Right(error);
    });
  }
}
