import 'package:flutter_ecommerce_app/data/model/Pagination.dart';

import 'BrandsModel.dart';

class BrandsResponse {
  BrandsResponse({
    this.results,
    this.metadata,
    this.data,
  });

  BrandsResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null ? Pagination.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BrandsModel.fromJson(v));
      });
    }
  }
  int? results;
  Pagination? metadata;
  List<BrandsModel>? data;

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
