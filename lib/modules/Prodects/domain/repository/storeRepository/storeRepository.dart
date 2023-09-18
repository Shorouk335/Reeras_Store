import 'package:flutter/material.dart';
import 'package:reeras_store/core/dataStore/dio.dart';
import 'package:reeras_store/modules/Prodects/domain/endPoint/end_point.dart';
import 'package:reeras_store/modules/Prodects/domain/model/model/product_model.dart';

class StoreRepository {
  static DioService dioService = DioService(baseUrl: StoreEndPoint.baseUrl);

  static dynamic getStoreData({required int? pageName}) async {
    List<Products> storeData = [];
    final appResponse = await dioService.getData(
      url: StoreEndPoint.urlGet,
      query: {StoreEndPoint.queryGet: pageName!},
    );
    if (appResponse.isError == false) {
      appResponse.data["products"].forEach((e) {
        storeData.add(Products.fromJson(e));
      });
      return storeData;
    }
    return appResponse.exception;
  }
  
  static dynamic showProdectData({required int? id}) async {
    Map<String, dynamic> products = {};
    final appResponse =
        await dioService.showData(url: "${StoreEndPoint.url}$id");
    if (appResponse.isError == false) {
      products = appResponse.data["products"];
      return products;
    }
    return appResponse.exception;
  }

  static dynamic deleteStoreData({required int? id}) async {
    final appResponse =
        await dioService.deleteData(url: "${StoreEndPoint.url}$id");
    if (appResponse.isError == false) {
      return appResponse.data["msg"];
    }
    return appResponse.exception;
  }

  static dynamic postProdect(
      {dynamic body,
      int? pageNamber,
      required BuildContext context,
      required bool Form}) async {
    final appResponse = await dioService.postData(
        url: StoreEndPoint.urlGet,
        query: {"page": pageNamber},
        body: body!,
        isForm: Form,
        loading: true);
    if (appResponse.isError == false) {
      return appResponse.data["msg"];
    }
    return appResponse.exception;
  }

  static editeDataRepository(
      {required int? id, required dynamic products ,required bool Form}) async {
    final appResponse = await dioService.updataData(
        url: "${StoreEndPoint.url}$id", body: products, loading: true ,isForm: Form);
    if (appResponse.isError == false) {
      return appResponse.data["msg"];
    }
    return appResponse.exception;
  }
}
