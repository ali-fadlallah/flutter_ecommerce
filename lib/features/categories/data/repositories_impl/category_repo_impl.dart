import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/categories/data/dao/datasource_contract/category_data_source.dart';
import 'package:flutter_ecommerce_app/features/categories/domain/entities/CategoryEntity.dart';
import 'package:flutter_ecommerce_app/features/categories/domain/repositories_contract/category_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoryRepository)
class CategoryRepositoryImpl extends CategoryRepository {
  CategoriesDataSourceContract categoriesOnlineDataSource;

  @factoryMethod
  CategoryRepositoryImpl(this.categoriesOnlineDataSource);

  @override
  Future<Either<List<CategoryEntity>, String>?> getCategories() async {
    var result = await categoriesOnlineDataSource.getCategories();

    return result?.fold((categoryResponse) {
      var categories = categoryResponse.data ?? [];

      var categoryEntities = categories.map((category) => category.toCategoryEntity()).toList();

      return Left(categoryEntities);
    }, (right) {
      return const Right(StringsManager.connectionError);
    });
  }
}
