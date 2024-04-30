import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/api/api_manager.dart';
import 'package:flutter_ecommerce_app/core/api/end_points.dart';
import 'package:flutter_ecommerce_app/core/local/shared_preference_helper.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/profile/data/dao/datasource_contract/profile_datasource.dart';
import 'package:injectable/injectable.dart';

import '../../../../authentication/data/models/AuthResponse.dart';

@Injectable(as: ProfileDataSource)
class ProfileDataSourceImpl extends ProfileDataSource {
  ApiManager apiManager;
  @factoryMethod
  ProfileDataSourceImpl(this.apiManager);

  @override
  Future<Either<AuthResponse, String>?> fetchProfileData() async {
    try {
      var response = await apiManager.putRequest(
        endPoint: EndPoints.updateData,
        headers: {
          'token': SharedPreferenceHelper.getToken(),
        },
      );
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
  Future<Either<AuthResponse, String>?> updateProfileData({required String name, required String email, required String phone}) async {
    try {
      var response = await apiManager.putRequest(
        endPoint: EndPoints.updateData,
        body: {
          "name": name,
          "email": email,
          "phone": phone,
        },
        headers: {
          'token': SharedPreferenceHelper.getToken(),
        },
      );
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
