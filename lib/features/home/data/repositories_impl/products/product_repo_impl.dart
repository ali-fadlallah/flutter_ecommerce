import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/products_entity/ProductEntity.dart';
import '../../../domain/repositories_contract/products/products_repo.dart';
import '../../dao/datasource_contract/products_datasource/product_datasource.dart';
import '../../models/products_response/ProductModel.dart';

@Injectable(as: ProductsRepo)
class ProductRepoImpl extends ProductsRepo {
  ProductDataSource onlineProductDataSource;
  @factoryMethod
  ProductRepoImpl(this.onlineProductDataSource);

  @override
  Future<Either<List<ProductEntity>, String>?> getProducts({String? sort}) async {
    var result = await onlineProductDataSource.getProducts(sort: sort);
    return result?.fold((productResponse) {
      List<ProductModel> productList = productResponse.data ?? [];

      List<ProductEntity> productEntityList = productList.map((productModel) => productModel.toProductEntity()).toList();

      return Left(productEntityList);
    }, (error) {
      return Right(error);
    });
  }
}
