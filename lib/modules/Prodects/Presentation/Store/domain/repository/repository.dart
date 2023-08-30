import 'package:reeras_store/core/data_store/dio.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/end_point.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class Store_Repository {
  static DioService? dioService =
      DioService(BaseUrl: Store_End_Point.Base_Url);

  static Future<List<Products>> GetStoreData({required int? PageName}) async {
    List<Products> Store_Data = [];
    final response = await dioService!.GetData(
      url: Store_End_Point.url_get,
      query: {Store_End_Point.query_get: PageName!},
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

  static  EditStoreData({required int? id ,required Products? products}) async {
    await dioService!.UpdataData(
      url: "${Store_End_Point.url}$id",
      body: products
    ).then((value) {
       print ("edit done");
     });}





}
