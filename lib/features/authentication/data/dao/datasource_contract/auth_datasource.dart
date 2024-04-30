import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/authentication/data/models/AuthResponse.dart';

abstract class AuthDataSource {
  Future<Either<AuthResponse, String>?> signUp({required String name, required String email, required String password, required String phone});
  Future<Either<AuthResponse, String>?> signIn({required String email, required String password});
}
