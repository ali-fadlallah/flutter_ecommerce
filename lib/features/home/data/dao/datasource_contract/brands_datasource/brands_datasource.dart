import 'package:dartz/dartz.dart';

import '../../../models/brands_response/BrandsResponse.dart';

abstract class BrandsDataSource {
  Future<Either<BrandsResponse, String>?> getBrands();
}
