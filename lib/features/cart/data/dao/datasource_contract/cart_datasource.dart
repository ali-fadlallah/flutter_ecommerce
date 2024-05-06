import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/Cart_response.dart';

abstract class CartDataSource {
  Future<Either<CartResponse, String>?> addToCart({required String productId});
}
