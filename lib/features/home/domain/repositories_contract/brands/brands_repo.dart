import 'package:dartz/dartz.dart';

import '../../entities/brands_entity/BrandsEntity.dart';

abstract class BrandsRepo {
  Future<Either<List<BrandsEntity>, String>?> getBrands();
}
