import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/category/category_repo.dart';
import 'package:injectable/injectable.dart';

import '../../entities/category_entity/CategoryEntity.dart';

@injectable
class GetCategoryUseCase {
  CategoryRepository categoryRepository;

  @factoryMethod
  GetCategoryUseCase(this.categoryRepository);

  Future<Either<List<CategoryEntity>, String>?> invoke() {
    return categoryRepository.getCategories();
  }
}
