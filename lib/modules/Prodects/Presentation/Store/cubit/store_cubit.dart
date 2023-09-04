
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/repository.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class StoreCubit extends Cubit<StoreState> {

  StoreCubit() : super(InitialStoreDataState());

  static StoreCubit get(context) => BlocProvider.of(context);

  List<Products> storeDataList = [];


  getStoreDataCubit({required int? pageNamber}) async {
     storeDataList=[];
    storeDataList = await StoreRepository.GetStoreData(PageName: pageNamber!);
    emit(GetStoreDataState());
  }

  deleteStoreDataCubit({required int? id}) async {
    await StoreRepository.DeleteStoreData(id: id!);
    await getStoreDataCubit(pageNamber: 1);
    emit(DeleteStoreDataState());
  }

  postProdectCubit ({required Map<String,dynamic>? data})async{
   await StoreRepository.postProdect(body: data);
   emit(PostProdectState());

  }


  EditDataCubit ({required int? id , required Products products}) async{
    print("goooooooooooooooooo");
    await StoreRepository.EditeDataRepository(id: id, products: products);
    emit(EditDataState());
    print("finnnnnnnnnnnnnnnnnn");
  }


}
