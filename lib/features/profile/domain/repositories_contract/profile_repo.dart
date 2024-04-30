import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/features/authentication/domain/entities/AuthEntity.dart';

abstract class ProfileRepo {
  Future<Either<AuthEntity, String>?> fetchProfileData();
  Future<Either<AuthEntity, String>?> updateProfileData({required String name, required String email, required String phone});
}
