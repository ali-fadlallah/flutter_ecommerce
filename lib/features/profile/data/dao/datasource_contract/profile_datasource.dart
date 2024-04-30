import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/authentication/data/models/AuthResponse.dart';

abstract class ProfileDataSource {
  Future<Either<AuthResponse, String>?> fetchProfileData();
  Future<Either<AuthResponse, String>?> updateProfileData({required String name, required String email, required String phone});
}
