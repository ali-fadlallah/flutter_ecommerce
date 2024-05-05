import 'CartEntity.dart';

class CartResponseEntity {
  CartResponseEntity({
    this.status,
    this.statusMsg,
    this.message,
    this.numOfCartItems,
    this.data,
  });

  num? numOfCartItems;
  CartEntity? data;
  String? status;
  String? statusMsg;
  String? message;
}
