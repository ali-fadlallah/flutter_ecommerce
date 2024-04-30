import 'package:flutter_ecommerce_app/features/categories/domain/entities/CategoryEntity.dart';

import '../brands_entity/BrandsEntity.dart';
import 'SubcategoryEntity.dart';

class ProductEntity {
  ProductEntity({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingsQuantity,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.priceAfterDiscount,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.id,
  });

  num? sold;
  List<String>? images;
  List<SubcategoryEntity>? subcategory;
  num? ratingsQuantity;
  String? title;
  String? slug;
  String? description;
  num? quantity;
  num? price;
  num? priceAfterDiscount;
  String? imageCover;
  CategoryEntity? category;
  BrandsEntity? brand;
  num? ratingsAverage;
  String? id;
}
