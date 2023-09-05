import 'package:reeras_store/core/data_store/dio.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/end_point.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class StoreRepository {
  static DioService dioService =
      DioService(BaseUrl: Store_End_Point.baseUrl);

  static Future<List<Products>> GetStoreData({required int? PageName}) async {
    List<Products> Store_Data = [];
    final response = await dioService!.GetData(
      url: Store_End_Point.urlGet,
      query: {Store_End_Point.queryGet: PageName!},
    );
    if (response.statusCode == 200) {
      response.data["products"].forEach((e) {
        Store_Data.add(Products.fromJson(e));
      });
    }
    return Store_Data;
  }

  static  DeleteStoreData({required int? id}) async {
     await dioService!.DeleteData(url: "${Store_End_Point.url}$id").then((value) {
       print("delete done ");
     });

  }

  static postProdect ({Map<String, dynamic>? body}) async{
    final response =   await dioService.PostData(
        url: Store_End_Point.urlGet,
        query: {"page" : 1 },
        body: body!
    );
  }


  static EditeDataRepository({required int? id ,required Products products}) async {
    await dioService.UpdataData(
        url: "${Store_End_Point.url}$id",
        body: products.toJson()
    ).then((value) {
      print ("edit done");
    });}




}
