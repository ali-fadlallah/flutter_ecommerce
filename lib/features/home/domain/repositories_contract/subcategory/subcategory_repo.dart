import 'package:dartz/dartz.dart';

import '../../entities/products_entity/SubcategoryEntity.dart';

abstract class SubCategoryRepository {
  Future<Either<List<SubcategoryEntity>, String>?> getSubCategory(String categoryID);
}
