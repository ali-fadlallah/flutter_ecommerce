import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/entities/category_entity/CategoryEntity.dart';

abstract class CategoryRepository {
  Future<Either<List<CategoryEntity>, String>?> getCategories();
}
