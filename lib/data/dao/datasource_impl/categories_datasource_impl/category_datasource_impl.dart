import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/api/api_manager.dart';
import 'package:flutter_ecommerce_app/core/api/end_points.dart';
import 'package:flutter_ecommerce_app/data/dao/datasource_contract/categories_datasource/category_data_source.dart';
import 'package:flutter_ecommerce_app/data/model/categories_response/CategoriesResponse.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/strings/strings_manager.dart';

@Injectable(as: CategoriesDataSourceContract)
class CategoriesDataSourceImpl extends CategoriesDataSourceContract {
  ApiManager apiManager;

  @factoryMethod
  CategoriesDataSourceImpl(this.apiManager);

  @override
  Future<Either<CategoriesResponse, String>?> getCategories() async {
    try {
      var response = await apiManager.getRequest(endPoint: EndPoints.allCategories);
      var result = CategoriesResponse.fromJson(response.data);
      return Left(result);
    } catch (error) {
      return const Right(StringsManager.connectionError);
      // return ;
    }
  }
}
