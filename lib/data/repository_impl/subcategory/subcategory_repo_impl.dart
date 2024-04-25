import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/data/dao/datasource_contract/subcategory_datasouce/subcategory_datasource.dart';
import 'package:flutter_ecommerce_app/data/model/products_response/SubcategoryModel.dart';
import 'package:flutter_ecommerce_app/domain/entities/products_entity/SubcategoryEntity.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/subcategory/subcategory_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SubCategoryRepository)
class SubCategoryRepoImpl extends SubCategoryRepository {
  SubCategoryDataSource subCategoryDataSource;

  @factoryMethod
  SubCategoryRepoImpl(this.subCategoryDataSource);

  @override
  Future<Either<List<SubcategoryEntity>, String>?> getSubCategory(String categoryID) async {
    var result = await subCategoryDataSource.getSubCategory(categoryID);
    return result?.fold((subCategory) {
      List<SubcategoryModel> subCategoryModelList = subCategory.data ?? [];
      List<SubcategoryEntity> subCategoryEntity = subCategoryModelList.map((subCategoryModel) => subCategoryModel.toSubCategoryEntity()).toList();
      return Left(subCategoryEntity);
    }, (error) {
      return Right(error);
    });
  }
}
