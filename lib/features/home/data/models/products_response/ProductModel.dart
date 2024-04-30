import '../../../../categories/data/models/CategoryModel.dart';
import '../../../domain/entities/products_entity/ProductEntity.dart';
import '../brands_response/BrandsModel.dart';
import 'SubcategoryModel.dart';

class ProductModel {
  ProductModel(
      {this.sold,
      this.images,
      this.subcategory,
      this.ratingsQuantity,
      this.id,
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
      this.createdAt,
      this.updatedAt});

  ProductModel.fromJson(dynamic json) {
    sold = json['sold'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['subcategory'] != null) {
      subcategory = [];
      json['subcategory'].forEach((v) {
        subcategory?.add(SubcategoryModel.fromJson(v));
      });
    }
    ratingsQuantity = json['ratingsQuantity'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    imageCover = json['imageCover'];
    category = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
    brand = json['brand'] != null ? BrandsModel.fromJson(json['brand']) : null;
    ratingsAverage = json['ratingsAverage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }
  num? sold;
  List<String>? images;
  List<SubcategoryModel>? subcategory;
  num? ratingsQuantity;
  String? id;
  String? title;
  String? slug;
  String? description;
  num? quantity;
  num? price;
  num? priceAfterDiscount;
  String? imageCover;
  CategoryModel? category;
  BrandsModel? brand;
  num? ratingsAverage;
  String? createdAt;
  String? updatedAt;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sold'] = sold;
    map['images'] = images;
    if (subcategory != null) {
      map['subcategory'] = subcategory?.map((v) => v.toJson()).toList();
    }
    map['ratingsQuantity'] = ratingsQuantity;
    map['_id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['quantity'] = quantity;
    map['price'] = price;
    map['imageCover'] = imageCover;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
    map['ratingsAverage'] = ratingsAverage;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['id'] = id;
    return map;
  }

  ProductEntity toProductEntity() {
    return ProductEntity(
      slug: slug,
      id: id,
      title: title,
      description: description,
      images: images,
      imageCover: imageCover,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      quantity: quantity,
      sold: sold,
      ratingsAverage: ratingsAverage,
      ratingsQuantity: ratingsQuantity,
      category: category?.toCategoryEntity(),
      brand: brand?.toBrandsEntity(),
      subcategory: subcategory?.map((subCategoryModel) => subCategoryModel.toSubCategoryEntity()).toList(),
    );
  }
}
