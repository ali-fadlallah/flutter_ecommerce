import 'package:flutter_ecommerce_app/features/cart/domain/entities/CartItemEntity.dart';
import 'package:flutter_ecommerce_app/features/home/data/models/products_response/ProductModel.dart';

class CartItemModel {
  CartItemModel({
    this.count,
    this.id,
    this.product,
    this.price,
  });

  CartItemModel.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    product = json['product'] is! String ? ProductModel.fromJson(json['product']) : null;
    price = json['price'];
  }

  num? count;
  String? id;
  ProductModel? product;
  num? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['_id'] = id;
    map['product'] = product;
    map['price'] = price;
    return map;
  }

  CartItemEntity toCartItemEntity() {
    return CartItemEntity(id: id, price: price, count: count, product: product?.toProductEntity());
  }
}
