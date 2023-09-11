import 'package:flutter/material.dart';
import 'package:reeras_store/core/data_store/dio.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/end_point.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class StoreRepository {
  static DioService dioService = DioService(baseUrl: StoreEndPoint.baseUrl);

  static Future<dynamic> getStoreData({required int? pageName}) async {
    List<Products> storeData = [];
    final response = await dioService.getData(
      url: StoreEndPoint.urlGet,
      query: {StoreEndPoint.queryGet: pageName!},
    );
    if (response.isError == false) {
      response.data["products"].forEach((e) {
        storeData.add(Products.fromJson(e));
      });
      return storeData;
    }
    return response.exception;
  }

  static deleteStoreData({required int? id}) async {
    await dioService.deleteData(url: "${StoreEndPoint.url}$id").then((value) {});
  }

  static Future<dynamic> postProdect({dynamic body, int? pageNamber, required BuildContext context}) async {
    final response = await dioService.postData(
      url: StoreEndPoint.url,
      body: body,
    );

    if (response.isError == false) {
      return response.data;
    } else {
      return response.exception;
    }
  }

  static editeDataRepository({required int? id, required Products products}) async {
    await dioService.updataData(url: "${StoreEndPoint.url}$id", body: products.toJson()).then((value) {});
  }
}
