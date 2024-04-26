import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/repository_contract/auth/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../entities/auth_entity/AuthEntity.dart';

@injectable
class SignUpAuthUseCase {
  AuthRepo authRepo;
  @factoryMethod
  SignUpAuthUseCase(this.authRepo);
  Future<Either<AuthEntity, String>?> callSignUp({required String name, required String email, required String password, required String phone}) =>
      authRepo.signUp(name: name, email: email, password: password, phone: phone);
}
