import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/authentication/domain/repositories_contract/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../entities/AuthEntity.dart';

@injectable
class SignUpAuthUseCase {
  AuthRepo authRepo;
  @factoryMethod
  SignUpAuthUseCase(this.authRepo);
  Future<Either<AuthEntity, String>?> callSignUp({required String name, required String email, required String password, required String phone}) =>
      authRepo.signUp(name: name, email: email, password: password, phone: phone);
}
