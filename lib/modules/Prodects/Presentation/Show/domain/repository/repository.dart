import 'package:reeras_store/core/data_store/dio.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/end_point.dart';

class ShowRepository {
  
  static DioService dioService = DioService(baseUrl:StoreEndPoint.baseUrl) ;

  static  dynamic  showStoreData ({required int? id})async{
    Map<String,dynamic> products = {} ;
   final response =await dioService.showData(url: "${StoreEndPoint.url}$id");
      if(response.statusCode == 200){
       products = response.data["products"];
      }
      return products ;
  }






}