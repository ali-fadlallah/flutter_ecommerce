import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/data/model/categories_response/CategoriesResponse.dart';

abstract class CategoriesDataSourceContract {
  Future<Either<CategoriesResponse, String>?> getCategories();
}
