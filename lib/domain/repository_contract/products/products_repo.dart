import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/entities/products_entity/ProductEntity.dart';

abstract class ProductsRepo {
  Future<Either<List<ProductEntity>, String>?> getProducts({String? sort});
}
