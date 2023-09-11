import 'package:dio/dio.dart';

class DioService {
  Dio _dio = Dio();
  DioService({required String? baseUrl, BaseOptions? options}) {
    _dio = Dio(
      options ??
          BaseOptions(
            headers: {"Accept": "application/json", "lang": "ar"},
            baseUrl: baseUrl!,
            contentType: "application/json",
            receiveDataWhenStatusError: true,
            connectTimeout: const Duration(milliseconds: 30000),
            receiveTimeout: const Duration(milliseconds: 30000),
            sendTimeout: const Duration(milliseconds: 30000),
          ),
      // to print the flow of dio
    )..interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
  }

  Future<Response> getData({
    required String? url,
    Map<String, dynamic>? query,
  }) async {
    return await _dio.get(url!, queryParameters: query);
  }

  Future<Response> showData({
    required String? url,
  }) async {
    return await _dio.get(url!);
  }

  Future<Response> postData({
    required String? url,
    required dynamic body,
    required Map<String, dynamic>? query,
  }) async {
    return await _dio.post(url!, data: body, queryParameters: query);
  }

  Future<Response> updataData({
    required String? url,
    Map<String, dynamic>? body,
  }) async {
    return await _dio.put(
      url!,
      data: body,
    );
  }

  Future<Response> deleteData({
    required String? url,
  }) async {
    final response = await _dio.delete(url!);
    return response;
  }
}
