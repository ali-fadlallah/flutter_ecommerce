import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/authentication/domain/entities/AuthEntity.dart';

abstract class AuthRepo {
  Future<Either<AuthEntity, String>?> signUp({required String name, required String email, required String password, required String phone});
  Future<Either<AuthEntity, String>?> signIn({required String email, required String password});
}
