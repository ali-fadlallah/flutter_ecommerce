import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/api/api_manager.dart';
import 'package:flutter_ecommerce_app/core/api/end_points.dart';
import 'package:flutter_ecommerce_app/core/local/shared_preference_helper.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/wishlist/data/models/AllWishListResponse.dart';
import 'package:flutter_ecommerce_app/features/wishlist/data/models/WishListResponse.dart';
import 'package:injectable/injectable.dart';

import '../datasource_contract/wish_list_data_souce.dart';

@Injectable(as: WishListDataSource)
class WishListDataSourceImpl extends WishListDataSource {
  ApiManager apiManager;

  @factoryMethod
  WishListDataSourceImpl(this.apiManager);

  @override
  Future<Either<WishListResponse, String>?> addToWishList({required String productId}) async {
    try {
      var response = await apiManager.postRequest(
        endPoint: EndPoints.wishList,
        body: {'productId': productId},
        headers: {
          'token': SharedPreferenceHelper.getData(key: StringsManager.keyToken),
        },
      );
      return Left(WishListResponse.fromJson(response.data));
    } catch (error) {
      return Right(StringsManager.internalServerError);
    }
  }

  @override
  Future<Either<AllWishListResponse, String>?> getWishList() async {
    try {
      var response = await apiManager.getRequest(
        endPoint: EndPoints.wishList,
        headers: {
          'token': SharedPreferenceHelper.getData(key: StringsManager.keyToken),
        },
      );

      return Left(AllWishListResponse.fromJson(response.data));
    } catch (error) {
      return Right(StringsManager.internalServerError);
    }
  }
}
