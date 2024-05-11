import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/wishlist/domain/repositories_contract/wish_list_repo.dart';
import 'package:injectable/injectable.dart';

import '../entities/WishListEntity.dart';

@injectable
class AddToWishListUseCase {
  WishListRepo wishListRepo;

  @factoryMethod
  AddToWishListUseCase(this.wishListRepo);

  Future<Either<WishListEntity, String>?> call({required String productId}) => wishListRepo.addToWishList(productId: productId);
}
