import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/api_base_url.dart';

@singleton
class ApiManager {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiBaseUrl.baseUrl,
        validateStatus: (status) {
          if (status! < 500) {
            return true;
          } else {
            return false;
          }
        },
      ),
    );
  }

  Future<Response> getRequest({required String endPoint, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    var response = await dio.get(endPoint, queryParameters: queryParameters, options: Options(headers: headers));
    return response;
  }

  Future<Response> postRequest({required String endPoint, Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    var response = await dio.post(endPoint, data: body, options: Options(headers: headers));
    return response;
  }

  Future<Response> putRequest({required String endPoint, Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    var response = await dio.put(endPoint, data: body, options: Options(headers: headers));
    return response;
  }

  Future<Response> deleteRequest({required String endPoint, Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    var response = await dio.delete(endPoint, data: body, options: Options(headers: headers));
    return response;
  }
}
