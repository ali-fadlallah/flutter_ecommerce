part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartScreenOnLoading extends CartState {}

final class CartScreenOnError extends CartState {
  final String? errorMsg;

  CartScreenOnError(this.errorMsg);
}

final class CartScreenOnSuccess extends CartState {
  final CartResponseEntity? cartResponseEntity;

  CartScreenOnSuccess(this.cartResponseEntity);
}

final class EmptyScreenCartSuccess extends CartState {}

final class CartCountUpdated extends CartState {
  final int? theNumber;

  CartCountUpdated(this.theNumber);
}

class UpdateCountSuccessState extends CartState {
  final CartResponseEntity responseEntity;

  UpdateCountSuccessState({required this.responseEntity});
}

class UpdateCountScreenLoadingState extends CartState {
  final String? productID;

  UpdateCountScreenLoadingState(this.productID);
}

class CartScreenCountChanged extends CartState {
  final int? theNewNumber;

  CartScreenCountChanged(this.theNewNumber);
}

class UpdateCountErrorState extends CartState {
  final String? errorMsg;

  UpdateCountErrorState(this.errorMsg);
}

class DeleteSuccessState extends CartState {
  final CartResponseEntity responseEntity;

  DeleteSuccessState({required this.responseEntity});
}

class DeleteItemLoadingState extends CartState {
  final String? productID;

  DeleteItemLoadingState(this.productID);
}

class DeleteItemErrorState extends CartState {
  final String? errorMsg;

  DeleteItemErrorState(this.errorMsg);
}

final class ClearCartOnSuccess extends CartState {}

final class ClearCartOnLoading extends CartState {}

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
