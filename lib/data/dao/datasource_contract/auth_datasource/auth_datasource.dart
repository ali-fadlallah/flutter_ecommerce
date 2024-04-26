import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/data/model/auth_response/AuthResponse.dart';

abstract class AuthDataSource {
  Future<Either<AuthResponse, String>?> signUp({required String name, required String email, required String password, required String phone});
  Future<Either<AuthResponse, String>?> signIn({required String email, required String password});
}
