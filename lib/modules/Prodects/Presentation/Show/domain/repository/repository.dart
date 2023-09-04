import 'package:reeras_store/core/data_store/dio.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/end_point.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class ShowRepository {
  
  static DioService dioService = DioService(BaseUrl:Store_End_Point.baseUrl) ;

  static  dynamic  showStoreData ({required int? id})async{
    Map<String,dynamic> products = {} ;
   final response =await dioService.ShowData(url: "${Store_End_Point.url}$id");
      if(response.statusCode == 200){
        print("rrrrrrrrrrrrrrrrrrr${response.data["products"]["id"]}");
       products = response.data["products"];
      }
      print(products["name"]);
      return products ;
  }






}