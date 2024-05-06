import 'CartEntity.dart';

class CartResponseEntity {
  CartResponseEntity({
    this.status,
    this.message,
    this.numOfCartItems,
    this.data,
  });

  num? numOfCartItems;
  CartEntity? data;
  String? status;
  String? message;
}
