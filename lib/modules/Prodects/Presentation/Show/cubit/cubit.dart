import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/domain/repository/repository.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class ShowDataCubit extends Cubit<ShowDataState>{

  ShowDataCubit():super (InitialShowState());

  static ShowDataCubit get(context) => BlocProvider.of(context);

  Products? showProdect;

  showStoreDataCubit({required int? id}) async {
    print("oooooooooo");
    showProdect =  Products.fromJson(await ShowRepository.showStoreData(id: id!) as Map<String,dynamic>);
    print("pppppp");
    print("ccccccccccc${showProdect!.id}");
    emit(GetShowState());

  }






}