import 'package:dio/dio.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/showDialogWidget.dart';

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

  Future<AppResponse> getData({
    required String? url,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(url!, queryParameters: query);
      //مش هوديله exception
      return AppResponse(data: response.data, isError: false);
    } on DioException catch (e) {
      HandelException(e);

      return AppResponse(data: e.response!.data, isError: true, exception: e);
    }
  }

  Future<AppResponse> showData({
    required String? url,
  }) async {
    try {
      final response = await _dio.get(url!);
      return AppResponse(data: response.data, isError: false);
    } on DioException catch (e) {
      HandelException(e);

      return AppResponse(data: e.response!.data, isError: true, exception: e);
    }
  }

  Future<AppResponse> postData({
    required String? url,
    required dynamic body,
    required Map<String, dynamic>? query,
    bool isForm = false,
    bool loading = false,
  }) async {
    try {
      if (loading) {
        showLoader();
      }
      final response = await _dio.post(url!,
          data: (isForm) ? FormData.fromMap(body) : body,
          queryParameters: query);
      if (loading) {
        dismissDialog();
      }
      return AppResponse(data: response.data, isError: false);
    } on DioException catch (e) {
      if (loading) {
        dismissDialog();
      }
      HandelException(e);
      return AppResponse(data: e.response!.data, isError: true, exception: e);
    }
  }

  Future<AppResponse> updataData({
    required String? url,
    Map<String, dynamic>? body,
    bool loading = false,
    bool isForm = false,
  }) async {
    try {
      if (loading) {
        showLoader();
      }
      final response = await _dio.put(
        url!,
        data: (isForm) ? FormData.fromMap(body!): body!,
      );
      if (loading) {
        dismissDialog();
      }
      return AppResponse(data: response.data, isError: false);
    } on DioException catch (e) {
      if (loading) {
        dismissDialog();
      }
      HandelException(e);
      return AppResponse(data: e.response!.data, isError: true, exception: e);
    }
  }

  Future<AppResponse> deleteData({
    required String? url,
  }) async {
    try {
      final response = await _dio.delete(url!);
      return AppResponse(data: response.data, isError: false);
    } on DioException catch (e) {
      HandelException(e);
      return AppResponse(data: e.response!.data, isError: true, exception: e);
    }
  }

  static HandelException(DioException exception) {
    if (exception.type == DioExceptionType.badResponse) {
      if (exception.response!.statusCode == 403) {
        showSmartToAst(msg: exception.response!.data["msg"]);
      } else {
        showSmartToAst(msg: exception.response!.data["msg"]);
      }
    }
    //مشكلة عندس مش عارفف اجيب داتا من السيرفر
    if (exception.type == DioExceptionType.connectionTimeout) {
    //  showSmartToAst(msg: exception.response!.data["msg"]);
    }
    // مش عارف ابعت داتا لسيرفر
    if (exception.type == DioExceptionType.sendTimeout) {
    //  showSmartToAst(msg: exception.response!.data["msg"]);
    }
    //مشكلة في السيرفر
    if (exception.type == DioExceptionType.receiveTimeout) {
     // showSmartToAst(msg: exception.response!.data["msg"]);
    }
    if (exception.type == DioExceptionType.unknown) {
     // showSmartToAst(msg: exception.error.toString());
    }
  }
}

class AppResponse {
  final dynamic data;
  bool isError = false;
  DioException? exception;

  AppResponse({required this.data, required this.isError, this.exception});
}
