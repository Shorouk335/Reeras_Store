
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/ProdectBox.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Prodect_Dialog.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storeStates.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storecubit.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          StoreCubit()..getStoreDataCubit(pageNamber: 1),
      child: BlocConsumer<StoreCubit, StoreState>(
          listener: (context, state) async {
  
      }, builder: (context, state) {
        StoreCubit storeCubit = StoreCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Reeras Store"),
            backgroundColor: Colors.red,
          ),
          body: state is SuccessfulGetStoreDataState &&
                  storeCubit.storeDataList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 1,
                          childAspectRatio: 1 / 1.3,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: storeCubit.storeDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context.goNamed(RouterNamed.show,
                                  extra: storeCubit.storeDataList[index].id);
                            },
                            child: ProdectBox(
                              key: UniqueKey(),
                              product: storeCubit.storeDataList[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : state is ErrorGetStoreDataState
                  ? const Center(
                      child: Text(" They are Wrong in getting Prodects "))
                  : const Center(
                      child: CircularProgressIndicator(
                      color: Colors.red,
                    )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return const AlertDialog(
                      title: Text(
                        'Post product',
                        style: TextStyle(color: Colors.red),
                      ),
                      content: ProdectDialog(
                        products: null,
                      ));
                },
              ).then((value) => storeCubit.getStoreDataCubit(pageNamber: 1));
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.add),
          ),
          // showAlertDialog(context: this.context ,title: "Post Prodect") ;
        );
      }),
    );
  }
}
