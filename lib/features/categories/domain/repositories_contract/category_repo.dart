import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/categories/domain/entities/CategoryEntity.dart';

abstract class CategoryRepository {
  Future<Either<List<CategoryEntity>, String>?> getCategories();
}
