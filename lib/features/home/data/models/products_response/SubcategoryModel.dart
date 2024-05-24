import '../../../domain/entities/products_entity/SubcategoryEntity.dart';

class SubcategoryModel {
  SubcategoryModel({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

  SubcategoryModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }
  String? id;
  String? name;
  String? slug;
  String? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['category'] = category;
    return map;
  }

  SubcategoryEntity toSubCategoryEntity() {
    return SubcategoryEntity(category: category, id: id, slug: slug, name: name);
  }
}
