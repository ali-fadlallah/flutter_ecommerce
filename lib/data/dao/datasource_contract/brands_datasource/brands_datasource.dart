import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/data/model/brands_response/BrandsResponse.dart';

abstract class BrandsDataSource {
  Future<Either<BrandsResponse, String>?> getBrands();
}
