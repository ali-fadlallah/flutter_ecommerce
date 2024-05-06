import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/cart/domain/repositories_contract/cart_repo_datasource.dart';
import 'package:injectable/injectable.dart';

import '../entities/CartResponseEntity.dart';

@injectable
class DeleteCartUseCase {
  CartRepoDataSource cartRepoDataSource;

  @factoryMethod
  DeleteCartUseCase(this.cartRepoDataSource);

  Future<Either<CartResponseEntity, String>?> call({required String productId}) => cartRepoDataSource.deleteCart(productId: productId);
}
