import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/products_entity/SubcategoryEntity.dart';
import '../../repositories_contract/subcategory/subcategory_repo.dart';

@injectable
class GetSubCategoryUseCase {
  SubCategoryRepository subCategoryRepository;
  @factoryMethod
  GetSubCategoryUseCase(this.subCategoryRepository);
  Future<Either<List<SubcategoryEntity>, String>?> call(String categoryID) => subCategoryRepository.getSubCategory(categoryID);
}
