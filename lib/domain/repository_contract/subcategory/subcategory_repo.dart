import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/entities/products_entity/SubcategoryEntity.dart';

abstract class SubCategoryRepository {
  Future<Either<List<SubcategoryEntity>, String>?> getSubCategory(String categoryID);
}
