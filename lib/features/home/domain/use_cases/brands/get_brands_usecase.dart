import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../entities/brands_entity/BrandsEntity.dart';
import '../../repositories_contract/brands/brands_repo.dart';

@injectable
class GetBrandsUseCase {
  BrandsRepo brandsRepo;
  @factoryMethod
  GetBrandsUseCase(this.brandsRepo);

  Future<Either<List<BrandsEntity>, String>?> call() {
    return brandsRepo.getBrands();
  }
}
