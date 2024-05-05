import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/cart/data/dao/datasource_contract/cart_datasource.dart';
import 'package:flutter_ecommerce_app/features/cart/domain/entities/CartResponseEntity.dart';
import 'package:flutter_ecommerce_app/features/cart/domain/repositories_contract/cart_repo_datasource.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepoDataSource)
class CartRepoImpl extends CartRepoDataSource {
  CartDataSource cartDataSource;

  @factoryMethod
  CartRepoImpl(this.cartDataSource);

  @override
  Future<Either<CartResponseEntity, String>?> addToCart({required String productId}) async {
    var response = await cartDataSource.addToCart(productId: productId);
    return response?.fold((response) {
      CartResponseEntity cartResponseEntity = response.toCartResponseEntity();
      return Left(cartResponseEntity);
    }, (error) {
      return Right(error);
    });
  }
}
