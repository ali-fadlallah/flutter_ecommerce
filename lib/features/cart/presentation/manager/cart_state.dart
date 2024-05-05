part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

// final class CartOnLoading extends CartState {}
//
// final class CartOnError extends CartState {
//   final String? errorMsg;
//   CartOnError(this.errorMsg);
// }
//
// final class CartOnSuccess extends CartState {
//   final CartResponseEntity? cartResponseEntity;
//
//   CartOnSuccess(this.cartResponseEntity);
// }
