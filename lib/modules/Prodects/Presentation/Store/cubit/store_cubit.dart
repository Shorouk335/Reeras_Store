import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/repository.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class Store_Cubit extends Cubit<Store_State> {

  Store_Cubit() : super(Initial_Store_Data_State());

  static Store_Cubit get(context) => BlocProvider.of(context);

  List<Products> Store_Data_List = [];


  Get_Store_Data_Cubit({required int? PageName}) async {
    Store_Data_List = await Store_Repository.GetStoreData(PageName: PageName!);
    emit(Get_Store_Data_State());
  }

  Delete_Store_Data_Cubit({required int? id}) async {
    await Store_Repository.DeleteStoreData(id: id!);
    Store_Data_List.clear();
     await Get_Store_Data_Cubit(PageName: 1);
    emit(Delete_Store_Data_State());
  }

  Edit_Store_Data_Cubit({required int? id, required Products? products}) {
    Store_Repository.EditStoreData(id: id, products: products);
    emit(Edit_Store_Data_State());
  }






}
