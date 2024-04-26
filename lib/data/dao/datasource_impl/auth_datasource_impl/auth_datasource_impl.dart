import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/api/api_manager.dart';
import 'package:flutter_ecommerce_app/core/api/end_points.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/data/dao/datasource_contract/auth_datasource/auth_datasource.dart';
import 'package:flutter_ecommerce_app/data/model/auth_response/AuthResponse.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl extends AuthDataSource {
  ApiManager apiManager;

  @factoryMethod
  AuthDataSourceImpl(this.apiManager);

  @override
  Future<Either<AuthResponse, String>?> signUp({required String name, required String email, required String password, required String phone}) async {
    try {
      var response = await apiManager.postRequest(endPoint: EndPoints.signUp, body: {
        'name': name,
        'email': email,
        'password': password,
        'rePassword': password,
        'phone': phone,
      });
      var authResponse = AuthResponse.fromJson(response.data);
      if (authResponse.statusMsg != null) {
        return Right(authResponse.message ?? '');
      } else {
        return Left(authResponse);
      }
    } catch (error) {
      return const Right(StringsManager.connectionError);
    }
  }

  @override
  Future<Either<AuthResponse, String>?> signIn({required String email, required String password}) async {
    try {
      var response = await apiManager.postRequest(endPoint: EndPoints.signIn, body: {
        'email': email,
        'password': password,
      });
      var authResponse = AuthResponse.fromJson(response.data);
      if (authResponse.statusMsg != null) {
        return Right(authResponse.message ?? '');
      } else {
        return Left(authResponse);
      }
    } catch (error) {
      return const Right(StringsManager.connectionError);
    }
  }
}
