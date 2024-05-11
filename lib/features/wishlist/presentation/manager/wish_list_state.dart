import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/features/home/domain/entities/products_entity/ProductEntity.dart';

import '../../domain/entities/WishListEntity.dart';

@immutable
sealed class WishListState {}

final class WishListInitial extends WishListState {}

final class WishListOnLoading extends WishListState {
  final String? productId;

  WishListOnLoading(this.productId);
}

final class GetWishListOnLoading extends WishListState {}

final class GetWishListOnSuccess extends WishListState {
  final List<ProductEntity>? productEntity;

  GetWishListOnSuccess(this.productEntity);
}

final class GetWishListOnError extends WishListState {
  final String? errorMsg;

  GetWishListOnError(this.errorMsg);
}

final class WishListOnSuccess extends WishListState {
  final WishListEntity? wishListEntity;
  final String? productId;

  WishListOnSuccess(this.wishListEntity, this.productId);
}

final class WishListOnError extends WishListState {
  final String? errorMsg;

  final String? productId;

  WishListOnError(this.errorMsg, this.productId);
}
