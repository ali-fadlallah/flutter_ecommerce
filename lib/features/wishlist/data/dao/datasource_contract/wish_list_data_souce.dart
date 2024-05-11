import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/wishlist/data/models/WishListResponse.dart';

import '../../models/AllWishListResponse.dart';

abstract class WishListDataSource {
  Future<Either<WishListResponse, String>?> addToWishList({required String productId});

  Future<Either<AllWishListResponse, String>?> getWishList();
}
