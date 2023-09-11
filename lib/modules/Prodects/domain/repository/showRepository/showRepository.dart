import 'package:reeras_store/core/dataStore/dio.dart';
import 'package:reeras_store/modules/Prodects/domain/endPoint/end_point.dart';

class ShowRepository {
  
  static DioService dioService = DioService(baseUrl:StoreEndPoint.baseUrl) ;

  static  dynamic  showStoreData ({required int? id})async{

    Map<String,dynamic> products = {} ;
   final appResponse =await dioService.showData(url: "${StoreEndPoint.url}$id"); 
     if(appResponse.isError == false) {
      products = appResponse.data["products"]; 
      return products ;
     }
      return appResponse.exception ;
  }






}