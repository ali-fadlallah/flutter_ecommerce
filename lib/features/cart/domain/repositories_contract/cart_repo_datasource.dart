import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/cart/domain/entities/CartResponseEntity.dart';

abstract class CartRepoDataSource {
  Future<Either<CartResponseEntity, String>?> addToCart({required String productId});

  Future<Either<CartResponseEntity, String>?> getCart();

  Future<Either<CartResponseEntity, String>?> updateCart({required String productId, required String count});

  Future<Either<CartResponseEntity, String>?> deleteCart({required String productId});

  Future<Either<CartResponseEntity, String>?> clearCart();
}
