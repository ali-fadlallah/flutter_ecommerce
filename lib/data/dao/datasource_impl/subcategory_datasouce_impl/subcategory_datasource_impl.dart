import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/api/api_manager.dart';
import 'package:flutter_ecommerce_app/core/api/end_points.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/data/dao/datasource_contract/subcategory_datasouce/subcategory_datasource.dart';
import 'package:flutter_ecommerce_app/data/model/subcategory_response/SubCategoryResponse.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SubCategoryDataSource)
class SubCategoryDataSourceImpl extends SubCategoryDataSource {
  ApiManager apiManager;
  @factoryMethod
  SubCategoryDataSourceImpl(this.apiManager);

  @override
  Future<Either<SubCategoryResponse, String>?> getSubCategory(String categoryID) async {
    // TODO: implement getSubCategory
    try {
      var response = await apiManager.getRequest(endPoint: EndPoints.getSubCategory(categoryID));
      return Left(SubCategoryResponse.fromJson(response.data));
    } catch (error) {
      return const Right(StringsManager.connectionError);
    }
  }
}
