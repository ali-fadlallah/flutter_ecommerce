
import 'package:flutter_ecommerce_app/data/model/Pagination.dart';
import 'package:flutter_ecommerce_app/data/model/products_response/SubcategoryModel.dart';

class SubCategoryResponse {
  SubCategoryResponse({
    this.results,
    this.metadata,
    this.data,
  });

  SubCategoryResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null ? Pagination.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SubcategoryModel.fromJson(v));
      });
    }
  }
  num? results;
  Pagination? metadata;
  List<SubcategoryModel>? data;

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
