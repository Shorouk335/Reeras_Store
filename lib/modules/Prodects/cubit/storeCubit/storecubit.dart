import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storeStates.dart';
import 'package:reeras_store/modules/Prodects/domain/repository/storeRepository/storeRepository.dart';
import 'package:reeras_store/modules/Prodects/domain/model/model/product_model.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(InitialStoreDataState());

  static StoreCubit get(context) => BlocProvider.of(context);

  List<Products> storeDataList = [];

  getStoreDataCubit({required int? pageNamber}) async {
    emit(LoadingStoreDataState());
    storeDataList = [];
    final data = await StoreRepository.getStoreData(pageName: pageNamber!);
    if (data is! DioException) {
      storeDataList = data;
      emit(SuccessfulGetStoreDataState());
    } else {
      emit(ErrorGetStoreDataState(error: data));
    }
  }

  deleteStoreDataCubit({required int? id}) async {
    emit(LoadingDeleteStoreDataState());

    final data = await StoreRepository.deleteStoreData(id: id!);
    if (data is! DioException) {
      emit(SuccessfulDeleteStoreDataState(msg: data));
      await getStoreDataCubit(pageNamber: 1);
    } else {
      emit(ErrorDeleteStoreDataState(error: data));
    }
  }

  postProdectCubit(
      {required dynamic data,
      required int? pageNumber,
      required BuildContext context ,
      required bool Form }) async {
    emit(LoadingPostStoreDataState());

    final dataa = await StoreRepository.postProdect(
        body: data, pageNamber: pageNumber, context: context ,Form: Form,);
    if (dataa is! DioException) {
      emit(SuccessfulPostProdectState(msg: dataa));
      await getStoreDataCubit(pageNamber: 1);
    } else {
      emit(ErrorPostStoreDataState(error: dataa));
    }

  }

  editDataCubit({required int? id, required Products products}) async {
    emit(LoadingEditStoreDataState());
    final data =
        await StoreRepository.editeDataRepository(id: id, products: products);
    if (data is! DioException) {
      emit(SuccefulEditDataState(msg: data));
      await getStoreDataCubit(pageNamber: 1);
    } else {
      emit(ErrorEditStoreDataState(error: data));
    }
  }
}
