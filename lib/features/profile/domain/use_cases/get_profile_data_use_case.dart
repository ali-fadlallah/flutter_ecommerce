import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/profile/domain/repositories_contract/profile_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../authentication/domain/entities/AuthEntity.dart';

@injectable
class GetProfileDataUseCase {
  ProfileRepo profileRepo;
  @factoryMethod
  GetProfileDataUseCase(this.profileRepo);

  Future<Either<AuthEntity, String>?> call() => profileRepo.fetchProfileData();
}
