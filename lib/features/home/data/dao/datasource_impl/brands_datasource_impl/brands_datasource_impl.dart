import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/api/api_manager.dart';
import 'package:flutter_ecommerce_app/core/api/end_points.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:injectable/injectable.dart';

import '../../../models/brands_response/BrandsResponse.dart';
import '../../datasource_contract/brands_datasource/brands_datasource.dart';

@Injectable(as: BrandsDataSource)
class BrandsDataSourceImpl extends BrandsDataSource {
  ApiManager apiManager;
  @factoryMethod
  BrandsDataSourceImpl(this.apiManager);

  @override
  Future<Either<BrandsResponse, String>?> getBrands() async {
    try {
      var response = await apiManager.getRequest(endPoint: EndPoints.allBrands);
      var result = BrandsResponse.fromJson(response.data);
      return Left(result);
    } catch (_) {
      return const Right(StringsManager.connectionError);
    }
  }
}
