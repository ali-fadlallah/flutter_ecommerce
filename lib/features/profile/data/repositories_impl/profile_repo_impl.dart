import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/authentication/domain/entities/AuthEntity.dart';
import 'package:flutter_ecommerce_app/features/profile/data/dao/datasource_contract/profile_datasource.dart';
import 'package:flutter_ecommerce_app/features/profile/domain/repositories_contract/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  ProfileDataSource profileDataSource;
  @factoryMethod
  ProfileRepoImpl(this.profileDataSource);
  @override
  Future<Either<AuthEntity, String>?> fetchProfileData() async {
    var result = await profileDataSource.fetchProfileData();
    return result?.fold((authResponse) {
      var response = authResponse.toAuthEntity();
      return Left(response);
    }, (error) {
      return Right(error);
    });
  }

  @override
  Future<Either<AuthEntity, String>?> updateProfileData({required String name, required String email, required String phone}) async {
    var result = await profileDataSource.updateProfileData(name: name, email: email, phone: phone);
    return result?.fold((authResponse) {
      var response = authResponse.toAuthEntity();
      return Left(response);
    }, (error) {
      return Right(error);
    });
  }
}
