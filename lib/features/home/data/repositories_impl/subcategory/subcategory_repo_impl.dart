import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/products_entity/SubcategoryEntity.dart';
import '../../../domain/repositories_contract/subcategory/subcategory_repo.dart';
import '../../dao/datasource_contract/subcategory_datasouce/subcategory_datasource.dart';
import '../../models/products_response/SubcategoryModel.dart';

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
