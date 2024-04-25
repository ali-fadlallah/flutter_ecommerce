import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/entities/brands_entity/BrandsEntity.dart';

abstract class BrandsRepo {
  Future<Either<List<BrandsEntity>, String>?> getBrands();
}
