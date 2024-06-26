import '../../../Pagination.dart';
import 'CategoryModel.dart';

class CategoriesResponse {
  CategoriesResponse({
    this.results,
    this.metadata,
    this.data,
  });

  CategoriesResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata = json['metadata'] != null ? Pagination.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryModel.fromJson(v));
      });
    }
  }
  int? results;
  Pagination? metadata;
  List<CategoryModel>? data;

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
