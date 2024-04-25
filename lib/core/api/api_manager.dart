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
      ),
    );
  }

  Future<Response> getRequest({required String endPoint, Map<String, dynamic>? queryParameters}) async {
    var response = await dio.get(endPoint, queryParameters: queryParameters);
    return response;
  }

  Future<Response> postRequest({required String endPoint, Map<String, dynamic>? body}) async {
    var response = await dio.post(endPoint, data: body);
    return response;
  }
}
