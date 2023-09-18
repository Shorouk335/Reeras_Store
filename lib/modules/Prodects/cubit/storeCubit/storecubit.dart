import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storeStates.dart';
import 'package:reeras_store/modules/Prodects/domain/repository/storeRepository/storeRepository.dart';
import 'package:reeras_store/modules/Prodects/domain/model/model/product_model.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(InitialStoreDataState());

  static StoreCubit get(context) => BlocProvider.of(context);

  List<Products> storeDataList = [];

  Products? showProdect; 

    //1 عدد العناصر الي بترجع من ال page الواحده
    static const pageSize = 10;

   //2 controller to listen  to every page by page key 
    // pagingController.itemList بياخد  نوع المودل ويعمل ليست من المودل ده جواه في 
    //int يعني نوع الداتا تايب بتاع key 
    PagingController<int, Products> pagingController =
      PagingController(firstPageKey: 1);  

      //3 fun to  build listen of page by key  and get data then  refresh pages
      //بستدعيها اما اعمل الكيوبت 
  addPageLisnter(){

    // لو انا عامل بروفيدر علي الماتريال كلها فمش هيتعمله dispose 
    //كدا اما افتح الصفحه الي فيها appanding هزود اليسينر والداتا هتتكرر 
    // فانا هقوله روح للكنترول وخليه يبدا من اول تاني  ب key = 1
    //  pagingController =
    //   PagingController(firstPageKey: 1); 
    
    //page key from controller start by 1 
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }
  
  //4 fun بتروح تجيب الداتا و الكنترول وتشوف الايرور 
  Future<void> fetchPage(int pageKey) async {
    try { 
      //الداتا الي هترجع من ال اي بي اي
      final storeDataList = await getStoreDataCubit(pageNamber: pageKey); 
      // عشان اعرف دي اخر عنصر واقف ولا اي 
      final isLastPage = storeDataList.length < pageSize;
      if (isLastPage) { 
        // روح للكنترول وخليه يعمل ابنت لاخر صفحه  و ياخد الداتا يضيفها ع الي عنده ويوقف تحميل داتا تاني 
        pagingController.appendLastPage(storeDataList);
      } else {
        //بشوف رقم الصفحه الجايه
        final nextPageKey = pageKey + 1; 
        //اروح للكنترول اقوله اعمل ابنت لصفحه الجاية ياخد الداتا و يضيفها ع الي عنده ورقم الصفحه الجايه ومش الاخيره
        pagingController.appendPage(storeDataList, nextPageKey );
      
      }
    } catch (error) { 

      pagingController.error = error;
    }
  } 
   //5 عشان اوقف اليسينر الي شغال اول ما يقفل ال بلوك بروفيدر 
   // لان لو مش اقفلته كل مره هيفتح الصفحه الي فيها البروفيدر
   //   وهيعمل ليسينر جديد والقديم شغال فالداتا هتتكرر
   // والميموري هتتملي 
  @override
  Future<void> close() {
      pagingController.dispose();
    return super.close();
  }
 
  
  getStoreDataCubit({required int? pageNamber}) async {
  //  emit(LoadingStoreDataState());
    storeDataList = [];
    final data = await StoreRepository.getStoreData(pageName: pageNamber!);
    if (data is! DioException) {
      storeDataList = data;
      return data;
    //  emit(SuccessfulGetStoreDataState());
    } else {
   //   emit(ErrorGetStoreDataState(error: data));
    }
  }

  showStoreDataCubit({required int? id}) async {
    emit(LoadingShowState());
    final data = await StoreRepository.showProdectData(id: id!);
    if (data is! DioException) {
      showProdect = Products.fromJson(data as Map<String, dynamic>);
      emit(GetShowState());
    } else {
      emit(ErrorShowState(error: data));
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
      required BuildContext context,
      required bool Form}) async {
    emit(LoadingPostStoreDataState());

    final dataa = await StoreRepository.postProdect(
      body: data,
      pageNamber: pageNumber,
      context: context,
      Form: Form,
    );
    if (dataa is! DioException) {
      emit(SuccessfulPostProdectState(msg: dataa));
      await getStoreDataCubit(pageNamber: 1);
    } else {
      emit(ErrorPostStoreDataState(error: dataa));
    }
  }

  editDataCubit({required int? id, required dynamic products , required bool? Form}) async {
    emit(LoadingEditStoreDataState());
    final data =
        await StoreRepository.editeDataRepository(id: id, products: products ,Form: Form!);
    if (data is! DioException) {
      emit(SuccefulEditDataState(msg: data));
      await getStoreDataCubit(pageNamber: 1);
    } else {
      emit(ErrorEditStoreDataState(error: data));
    }
  }
 
}
