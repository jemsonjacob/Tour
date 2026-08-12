import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Authorization': 'Bearer ${ApiConstants.apiKey}',
          'X-Places-Api-Version': '2025-06-17',
          'Accept': 'application/json',
        },
      ),
    );

    /// dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
