part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartOnLoading extends CartState {}

final class CartOnError extends CartState {
  final String? errorMsg;

  CartOnError(this.errorMsg);
}

final class GetCartOnSuccess extends CartState {
  final CartResponseEntity? cartResponseEntity;

  GetCartOnSuccess(this.cartResponseEntity);
}

final class CartCountUpdated extends CartState {
  final int? theNumber;

  CartCountUpdated(this.theNumber);
}

class UpdateCountSuccessState extends CartState {
  final CartResponseEntity responseEntity;

  UpdateCountSuccessState({required this.responseEntity});
}

class UpdateCountLoadingState extends CartState {}

class UpdateCountErrorState extends CartState {
  final String? errorMsg;

  UpdateCountErrorState(this.errorMsg);
}

class DeleteSuccessState extends CartState {
  final CartResponseEntity responseEntity;

  DeleteSuccessState({required this.responseEntity});
}

class DeleteItemLoadingState extends CartState {}

class DeleteItemErrorState extends CartState {
  final String? errorMsg;

  DeleteItemErrorState(this.errorMsg);
}

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
