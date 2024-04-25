import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/data/dao/datasource_contract/categories_datasource/category_data_source.dart';
import 'package:flutter_ecommerce_app/domain/entities/category_entity/CategoryEntity.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/category/category_repo.dart';
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
