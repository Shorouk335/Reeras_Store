import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/repository.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/showDialogWidget.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(InitialStoreDataState());

  static StoreCubit get(context) => BlocProvider.of(context);

  List<Products> storeDataList = [];

  getStoreDataCubit({required int? pageNamber}) async {
    emit(LoadingStoreDataState());
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
    try {
      await StoreRepository.deleteStoreData(id: id!);
      emit(SuccessfulDeleteStoreDataState());
    } catch (e) {
      emit(ErrorDeleteStoreDataState());
    }
    await getStoreDataCubit(pageNamber: 1);
  }

  postProdectCubit({required dynamic data, required int? pageNumber, required BuildContext context}) async {
    emit(LoadingPostStoreDataState());
    final response = await StoreRepository.postProdect(body: data, pageNamber: pageNumber, context: context);
    if (response is DioException) {
      emit(ErrorPostStoreDataState(error: response));
      return;
    } else {
      emit(SuccessfulPostProdectState());
      showDialogWidget(context: context, title: "message", body: response.data["msg"]);
      await getStoreDataCubit(pageNamber: 1);
      Navigator.pop(context);
    }
  }

  editDataCubit({required int? id, required Products products}) async {
    emit(LoadingEditStoreDataState());
    try {
      await StoreRepository.editeDataRepository(id: id, products: products);
      emit(SuccefulEditDataState());
    } catch (e) {
      emit(ErrorEditStoreDataState());
    }
    await getStoreDataCubit(pageNamber: 1);
  }
}
