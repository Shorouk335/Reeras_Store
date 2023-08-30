import 'package:dio/dio.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';
class DioService {

  Dio _dio = Dio();
  DioService({required String? BaseUrl, BaseOptions? options }){
    _dio= Dio(
        options ??
        BaseOptions(
          headers: {
            "Accept" :"application/json",
            "lang": "ar"
          },
           baseUrl: BaseUrl!,
            contentType: "application/json",
            receiveDataWhenStatusError: true,
            connectTimeout: Duration(milliseconds: 30000),
            receiveTimeout: Duration(milliseconds: 30000),
            sendTimeout: Duration(milliseconds: 30000),
        ),
      // to print the flow of dio
    )..interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    );

  }

   Future<Response> GetData ({
    required String? url ,
    Map<String, dynamic>? query,
  })async{
    return await _dio.get(url!,queryParameters: query );

  }

  Future<Response> ShowData ({
    required String? url ,
  })async{
    return await _dio.get(url!);

  }


  Future<Response> PostData ({
    required String? url ,
    Map<String, dynamic>? body,
  })async{
    return await _dio.post(url!,data: body);

  }

  Future<Response> UpdataData ({
    required String? url ,
    Products? body,
  })async{
    return  await _dio.put(url!,data: {},);

  }

  Future<Response> DeleteData ({
    required String? url ,
  })async{
    final response = await _dio.delete(url!);
    return response ;
  }






}