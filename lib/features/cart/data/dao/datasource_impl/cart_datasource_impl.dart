import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/api/api_manager.dart';
import 'package:flutter_ecommerce_app/core/api/end_points.dart';
import 'package:flutter_ecommerce_app/core/local/shared_preference_helper.dart';
import 'package:flutter_ecommerce_app/core/utils/strings/strings_manager.dart';
import 'package:flutter_ecommerce_app/features/cart/data/dao/datasource_contract/cart_datasource.dart';
import 'package:flutter_ecommerce_app/features/cart/data/models/Cart_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartDataSource)
class CartDataSourceImpl extends CartDataSource {
  ApiManager apiManager;

  @factoryMethod
  CartDataSourceImpl(this.apiManager);

  @override
  Future<Either<CartResponse, String>?> addToCart({required String productId}) async {
    try {
      var result = await apiManager.postRequest(
        endPoint: EndPoints.cart,
        body: {"productId": productId},
        headers: {
          'token': SharedPreferenceHelper.getData(key: StringsManager.keyToken),
        },
      );
      CartResponse cartResponse = CartResponse.fromJson(result.data);
      if (cartResponse.statusMsg != null) {
        return Right(result.statusMessage ?? '');
      } else {
        return Left(cartResponse);
      }
    } catch (e) {
      return const Right(StringsManager.connectionError);
    }
  }

  @override
  Future<Either<CartResponse, String>?> getCart() async {
    try {
      var result = await apiManager.getRequest(
        endPoint: EndPoints.cart,
        headers: {
          'token': SharedPreferenceHelper.getData(key: StringsManager.keyToken),
        },
      );
      CartResponse cartResponse = CartResponse.fromJson(result.data);
      if (cartResponse.statusMsg != null) {
        return Right(result.statusMessage ?? '');
      } else {
        return Left(cartResponse);
      }
    } catch (e) {
      return const Right(StringsManager.connectionError);
    }
  }

  @override
  Future<Either<CartResponse, String>?> updateCart({required String productId, required String count}) async {
    try {
      var result = await apiManager.putRequest(
        endPoint: EndPoints.updateCart(productId),
        body: {'count': count},
        headers: {
          'token': SharedPreferenceHelper.getData(key: StringsManager.keyToken),
        },
      );
      CartResponse cartResponse = CartResponse.fromJson(result.data);
      if (cartResponse.statusMsg != null) {
        return Right(result.statusMessage ?? '');
      } else {
        return Left(cartResponse);
      }
    } catch (e) {
      return const Right(StringsManager.connectionError);
    }
  }

  @override
  Future<Either<CartResponse, String>?> deleteCart({required String productId}) async {
    try {
      var result = await apiManager.deleteRequest(
        endPoint: EndPoints.deleteCart(productId),
        headers: {
          'token': SharedPreferenceHelper.getData(key: StringsManager.keyToken),
        },
      );
      CartResponse cartResponse = CartResponse.fromJson(result.data);
      if (cartResponse.statusMsg != null) {
        return Right(result.statusMessage ?? '');
      } else {
        return Left(cartResponse);
      }
    } catch (e) {
      return const Right(StringsManager.connectionError);
    }
  }
}
