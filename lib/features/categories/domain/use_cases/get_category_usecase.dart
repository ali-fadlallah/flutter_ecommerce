import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/categories/domain/repositories_contract/category_repo.dart';
import 'package:injectable/injectable.dart';

import '../entities/CategoryEntity.dart';

@injectable
class GetCategoryUseCase {
  CategoryRepository categoryRepository;

  @factoryMethod
  GetCategoryUseCase(this.categoryRepository);

  Future<Either<List<CategoryEntity>, String>?> invoke() {
    return categoryRepository.getCategories();
  }
}
