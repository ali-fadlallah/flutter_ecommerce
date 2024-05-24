import 'package:dartz/dartz.dart';

import '../../../models/subcategory_response/SubCategoryResponse.dart';

abstract class SubCategoryDataSource {
  Future<Either<SubCategoryResponse, String>?> getSubCategory(String categoryID);
}
