import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reeras_store/modules/Prodects/cubit/showCubit/showStates.dart';
import 'package:reeras_store/modules/Prodects/domain/repository/showRepository/showRepository.dart';
import 'package:reeras_store/modules/Prodects/domain/model/model/product_model.dart';

class ShowDataCubit extends Cubit<ShowDataState>{

  ShowDataCubit():super (InitialShowState());

  static ShowDataCubit get(context) => BlocProvider.of(context);

  Products? showProdect;

  showStoreDataCubit({required int? id}) async { 
    emit(LoadingShowState());
     final data = await ShowRepository.showStoreData(id: id!) ;
     if (data is! DioException){
       showProdect = Products.fromJson(data as Map<String,dynamic>) ; 
       emit(GetShowState());
     } else {
      emit(ErrorShowState(error: data));
     }
    
   
    

  }






}