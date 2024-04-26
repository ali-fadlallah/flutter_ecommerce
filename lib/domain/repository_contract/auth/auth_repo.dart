import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/domain/entities/auth_entity/AuthEntity.dart';

abstract class AuthRepo {
  Future<Either<AuthEntity, String>?> signUp({required String name, required String email, required String password, required String phone});
  Future<Either<AuthEntity, String>?> signIn({required String email, required String password});
}
