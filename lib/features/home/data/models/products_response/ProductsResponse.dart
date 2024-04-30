import 'package:flutter_ecommerce_app/features/Pagination.dart';

import 'ProductModel.dart';

class ProductsResponse {
  ProductsResponse({
    this.results,
    this.metadata,
    this.data,
  });

  ProductsResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null ? Pagination.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductModel.fromJson(v));
      });
    }
  }
  num? results;
  Pagination? metadata;
  List<ProductModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
