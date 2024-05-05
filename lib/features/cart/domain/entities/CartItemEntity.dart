import 'package:flutter_ecommerce_app/features/home/domain/entities/products_entity/ProductEntity.dart';

class CartItemEntity {
  CartItemEntity({
    this.count,
    this.id,
    this.product,
    this.price,
  });

  num? count;
  String? id;
  ProductEntity? product;
  num? price;
}
