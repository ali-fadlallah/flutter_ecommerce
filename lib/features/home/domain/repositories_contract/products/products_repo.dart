import 'package:dartz/dartz.dart';

import '../../entities/products_entity/ProductEntity.dart';

abstract class ProductsRepo {
  Future<Either<List<ProductEntity>, String>?> getProducts({String? sort});
}
