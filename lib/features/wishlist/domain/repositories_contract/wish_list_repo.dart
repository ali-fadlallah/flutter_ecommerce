import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/wishlist/domain/entities/WishListEntity.dart';

import '../../../home/domain/entities/products_entity/ProductEntity.dart';

abstract class WishListRepo {
  Future<Either<WishListEntity, String>?> addToWishList({required String productId});

  Future<Either<List<ProductEntity>, String>?> getWishList();
}
