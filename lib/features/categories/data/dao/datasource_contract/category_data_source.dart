import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/categories/data/models/CategoriesResponse.dart';

abstract class CategoriesDataSourceContract {
  Future<Either<CategoriesResponse, String>?> getCategories();
}
