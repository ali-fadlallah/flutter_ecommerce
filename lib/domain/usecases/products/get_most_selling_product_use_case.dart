import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/data/dao/datasource_contract/products_datasource/product_datasource.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/products/products_repo.dart';
import 'package:injectable/injectable.dart';

import '../../entities/products_entity/ProductEntity.dart';

@injectable
class GetMostSellingProductsUseCase {
  ProductsRepo productsRepo;
  @factoryMethod
  GetMostSellingProductsUseCase(this.productsRepo);

  Future<Either<List<ProductEntity>, String>?> call() {
    return productsRepo.getProducts(sort: ProductSortType.mostSelling.sort);
  }
}
