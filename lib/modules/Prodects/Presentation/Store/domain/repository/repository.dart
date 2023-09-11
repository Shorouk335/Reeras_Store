import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reeras_store/core/data_store/dio.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/end_point.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/showDialogWidget.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class StoreRepository {
  static DioService dioService = DioService(baseUrl: StoreEndPoint.baseUrl);

  static Future<List<Products>> getStoreData({required int? pageName}) async {
    List<Products> storeData = [];
    final response = await dioService.getData(
      url: StoreEndPoint.urlGet,
      query: {StoreEndPoint.queryGet: pageName!},
    );
    if (response.statusCode == 200) {
      response.data["products"].forEach((e) {
        storeData.add(Products.fromJson(e));
      });
    }
    return storeData;
  }

  static deleteStoreData({required int? id}) async {
    await dioService
        .deleteData(url: "${StoreEndPoint.url}$id")
        .then((value) {});
  }

  static Future<Response> postProdect(
      {dynamic body, int? pageNamber, required BuildContext context}) async {
    return await dioService.postData(
        url: StoreEndPoint.urlGet, query: {"page": pageNamber}, body: body!);
  }

  static editeDataRepository(
      {required int? id, required Products products}) async {
    await dioService
        .updataData(url: "${StoreEndPoint.url}$id", body: products.toJson())
        .then((value) {});
  }
}
