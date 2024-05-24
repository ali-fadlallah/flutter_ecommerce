import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/wishlist/domain/repositories_contract/wish_list_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../home/domain/entities/products_entity/ProductEntity.dart';

@injectable
class GetWishListUseCase {
  WishListRepo wishListRepo;

  @factoryMethod
  GetWishListUseCase(this.wishListRepo);

  Future<Either<List<ProductEntity>, String>?> call() => wishListRepo.getWishList();
}
