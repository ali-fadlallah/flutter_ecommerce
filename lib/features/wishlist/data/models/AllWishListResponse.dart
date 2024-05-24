import 'package:flutter_ecommerce_app/features/home/data/models/products_response/ProductModel.dart';

class AllWishListResponse {
  AllWishListResponse({
    this.status,
    this.statusMsg,
    this.message,
    this.count,
    this.data,
  });

  AllWishListResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMsg = json['statusMsg'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductModel.fromJson(v));
      });
    }
  }

  String? status;
  String? statusMsg;
  String? message;
  num? count;
  List<ProductModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['statusMsg'] = statusMsg;
    map['message'] = message;
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
