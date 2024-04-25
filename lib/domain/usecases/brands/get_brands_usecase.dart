import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/entities/brands_entity/BrandsEntity.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/brands/brands_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBrandsUseCase {
  BrandsRepo brandsRepo;
  @factoryMethod
  GetBrandsUseCase(this.brandsRepo);

  Future<Either<List<BrandsEntity>, String>?> call() {
    return brandsRepo.getBrands();
  }
}
