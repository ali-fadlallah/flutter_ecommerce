import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/data/model/subcategory_response/SubCategoryResponse.dart';

abstract class SubCategoryDataSource {
  Future<Either<SubCategoryResponse, String>?> getSubCategory(String categoryID);
}
