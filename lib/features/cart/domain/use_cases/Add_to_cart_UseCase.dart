import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/cart/domain/repositories_contract/cart_repo_datasource.dart';
import 'package:injectable/injectable.dart';

import '../entities/CartResponseEntity.dart';

@injectable
class AddToCartUseCase {
  CartRepoDataSource cartRepoDataSource;

  @factoryMethod
  AddToCartUseCase(this.cartRepoDataSource);

  Future<Either<CartResponseEntity, String>?> call({required String productId}) => cartRepoDataSource.addToCart(productId: productId);
}
