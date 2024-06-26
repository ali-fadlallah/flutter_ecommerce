import 'package:dartz/dartz.dart';

import '../../../models/products_response/ProductsResponse.dart';

abstract class ProductDataSource {
  Future<Either<ProductsResponse, String>?> getProducts({String? sort});
}

enum ProductSortType {
  mostSelling('-sold'),
  lowSelling('sold'),
  highPrice('-price'),
  lowPrice('price');

  final String? sort;
  const ProductSortType(this.sort);
}
