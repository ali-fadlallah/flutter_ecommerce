import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/dao/datasource_contract/products_datasource/product_datasource.dart';
import '../../entities/products_entity/ProductEntity.dart';
import '../../repositories_contract/products/products_repo.dart';

@injectable
class GetMostSellingProductsUseCase {
  ProductsRepo productsRepo;
  @factoryMethod
  GetMostSellingProductsUseCase(this.productsRepo);

  Future<Either<List<ProductEntity>, String>?> call() {
    return productsRepo.getProducts(sort: ProductSortType.mostSelling.sort);
  }
}
