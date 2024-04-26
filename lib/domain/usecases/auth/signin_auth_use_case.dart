import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/auth/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../entities/auth_entity/AuthEntity.dart';

@injectable
class SignInAuthUseCase {
  AuthRepo authRepo;
  @factoryMethod
  SignInAuthUseCase(this.authRepo);
  Future<Either<AuthEntity, String>?> callSignIn({required String email, required String password}) =>
      authRepo.signIn(email: email, password: password);
}
