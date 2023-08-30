import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/domain/repository/repository.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class Show_Data_Cubit extends Cubit<Show_Data_State>{

  Show_Data_Cubit():super (Initial_Show_State());

  static Show_Data_Cubit get(context) => BlocProvider.of(context);

  Products? show_Prodect;

  Show_Store_Data_Cubit({required int? id}) async {
    print("oooooooooo");
    show_Prodect =  Products.fromJson(await ShowRepository.ShowStoreData(id: id!) as Map<String,dynamic>);
    print("pppppp");
    print("ccccccccccc${show_Prodect!.id}");
    emit(Get_Show_State());

  }






}