import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/Presentaion/Widget/ProdectBox.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/store_cubit.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/Prodect_Dialog.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/TextForm_Widget.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {


  @override
//   void initState() {
// stockController.text= produxt.stock    super.initState();
//   }
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>
          StoreCubit()..getStoreDataCubit(pageNamber: 1),
      child: BlocConsumer<StoreCubit, StoreState>(
          listener: (context, state) {},
          builder: (context, state) {
            StoreCubit store_cubit = StoreCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text("Reeras Store"),
                backgroundColor: Colors.red,
              ),
              body: store_cubit.storeDataList.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 1,
                              childAspectRatio: 1 / 1.3,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: store_cubit.storeDataList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  context.goNamed(RouterNamed.Show,
                                      extra:
                                          store_cubit.storeDataList[index].id);
                                },
                                child: ProdectBox(
                                  key: UniqueKey(),
                                  product: store_cubit.storeDataList[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                   showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Post product',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: ProdectDialog(storeCubit: store_cubit ,products: null,)
                      );
                    },
                  ).then((value) => store_cubit.getStoreDataCubit(pageNamber: 1));
                },
                backgroundColor: Colors.red,
                child: Icon(Icons.add),
              ),
              // showAlertDialog(context: this.context ,title: "Post Prodect") ;
            );
          }),
    );
  }
}
