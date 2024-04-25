import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/subcategory/subcategory_repo.dart';
import 'package:injectable/injectable.dart';

import '../../entities/products_entity/SubcategoryEntity.dart';

@injectable
class GetSubCategoryUseCase {
  SubCategoryRepository subCategoryRepository;
  @factoryMethod
  GetSubCategoryUseCase(this.subCategoryRepository);
  Future<Either<List<SubcategoryEntity>, String>?> call(String categoryID) => subCategoryRepository.getSubCategory(categoryID);
}
