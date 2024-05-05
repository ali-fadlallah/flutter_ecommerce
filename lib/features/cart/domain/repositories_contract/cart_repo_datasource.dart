import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/cart/domain/entities/CartResponseEntity.dart';

abstract class CartRepoDataSource {
  Future<Either<CartResponseEntity, String>?> addToCart({required String productId});
}
