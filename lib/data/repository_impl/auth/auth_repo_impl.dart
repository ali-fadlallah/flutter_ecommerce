import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/data/dao/datasource_contract/auth_datasource/auth_datasource.dart';
import 'package:flutter_ecommerce_app/domain/entities/auth_entity/AuthEntity.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/auth/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  AuthDataSource authDataSource;

  @factoryMethod
  AuthRepoImpl(this.authDataSource);

  @override
  Future<Either<AuthEntity, String>?> signUp({required String name, required String email, required String password, required String phone}) async {
    var result = await authDataSource.signUp(name: name, email: email, password: password, phone: phone);
    return result?.fold((response) {
      AuthEntity authEntity = response.toAuthEntity();
      return Left(authEntity);
    }, (error) {
      return Right(error);
    });
  }

  @override
  Future<Either<AuthEntity, String>?> signIn({required String email, required String password}) async {
    var result = await authDataSource.signIn(email: email, password: password);
    return result?.fold((response) {
      AuthEntity authEntity = response.toAuthEntity();
      return Left(authEntity);
    }, (error) {
      return Right(error);
    });
  }
}
