import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/ProdectBox.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Prodect_Dialog.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storeStates.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storecubit.dart';
import 'package:reeras_store/modules/Prodects/domain/model/model/product_model.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //   بستدعي اليسينر من الكنترول  الي فيه الداتا الوقتي
      create: (BuildContext context) => StoreCubit()..addPageLisnter(),
      child: BlocConsumer<StoreCubit, StoreState>(
          listener: (context, state) async {},
          builder: (context, state) {
            StoreCubit storeCubit = StoreCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text("Reeras Store"),
                backgroundColor: Colors.red,
              ),
              body: Column(
                children: [
                  Expanded(
                    //grid view by paginition
                    child: PagedGridView<int, Products>( 
                      //عشان الودينج يظهر تحت مش في الجرد
                      showNewPageErrorIndicatorAsGridChild: false,
                      //controller
                      pagingController: storeCubit.pagingController,
                      //Products is type of list  controller
                      builderDelegate: PagedChildBuilderDelegate<Products>(
                          //رجع لست فاضيه مش ايرور
                          noItemsFoundIndicatorBuilder: (context) {
                            return const Center(
                                child: Text(" They are no data "));
                          },
                          //خلص الداتا
                          noMoreItemsIndicatorBuilder: (context) {
                            return const Center(child: Text(" the end"));
                          },
                          //error
                          firstPageErrorIndicatorBuilder: (context) {
                            return const Center(
                                child: Text(" They are error in get data "));
                          },
                          //loading
                          firstPageProgressIndicatorBuilder: (context) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.red,
                            ));
                          },

                          // item => هي الليست الي في الكنترولر  ب ال index
                          // controll =>itemlist=>storedatalist[index]=> item
                          itemBuilder: (context, item, index) => InkWell(
                                onTap: () {
                                  context.goNamed(RouterNamed.show,
                                      extra: item.id);
                                },
                                child: ProdectBox(
                                  key: UniqueKey(),
                                  product: item,
                                ),
                              )),
                    
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 1,
                        childAspectRatio: 1 / 1.3,
                      ),
                      scrollDirection: Axis.vertical,
                      //itemCount: storeCubit.storeDataList.length,
                    ),
                  ),
                ],
              ),

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
                  ).then(
                      (value) => storeCubit.getStoreDataCubit(pageNamber: 1));
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
