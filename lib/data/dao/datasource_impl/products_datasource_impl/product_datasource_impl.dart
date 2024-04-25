import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/api/api_manager.dart';
import 'package:flutter_ecommerce_app/core/api/end_points.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/data/dao/datasource_contract/products_datasource/product_datasource.dart';
import 'package:flutter_ecommerce_app/data/model/products_response/ProductsResponse.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDataSource)
class ProductDataSourceImpl extends ProductDataSource {
  ApiManager apiManager;
  @factoryMethod
  ProductDataSourceImpl(this.apiManager);

  @override
  Future<Either<ProductsResponse, String>?> getProducts({String? sort}) async {
    try {
      var response = await apiManager.getRequest(endPoint: EndPoints.products, queryParameters: sort != null ? {'sort': sort} : null);

      return Left(ProductsResponse.fromJson(response.data));
    } catch (error) {
      return const Right(StringsManager.connectionError);
    }
  }
}
