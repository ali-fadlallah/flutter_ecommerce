import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/profile/domain/repositories_contract/profile_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../authentication/domain/entities/AuthEntity.dart';

@injectable
class UpdateProfileDataUseCase {
  ProfileRepo profileRepo;
  @factoryMethod
  UpdateProfileDataUseCase(this.profileRepo);

  Future<Either<AuthEntity, String>?> call({required String name, required String email, required String phone}) =>
      profileRepo.updateProfileData(name: name, email: email, phone: phone);
}
