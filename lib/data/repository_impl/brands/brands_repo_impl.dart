import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/data/dao/datasource_contract/brands_datasource/brands_datasource.dart';
import 'package:flutter_ecommerce_app/domain/entities/brands_entity/BrandsEntity.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/brands/brands_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BrandsRepo)
class BrandsRepoImpl extends BrandsRepo {
  BrandsDataSource brandsDataSource;

  @factoryMethod
  BrandsRepoImpl(this.brandsDataSource);

  @override
  Future<Either<List<BrandsEntity>, String>?> getBrands() async {
    var result = await brandsDataSource.getBrands();

    return result?.fold((brandsResponse) {
      var response = brandsResponse.data ?? [];
      var brandsEntities = response.map((brandsModel) => brandsModel.toBrandsEntity()).toList();
      return Left(brandsEntities);
    }, (error) {
      return const Right(StringsManager.connectionError);
    });
  }
}
