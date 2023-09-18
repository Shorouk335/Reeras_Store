import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Prodect_Dialog.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/Variation.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storeStates.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storecubit.dart';

// ignore: must_be_immutable
class ShowPage extends StatelessWidget {
  int? id;
  ShowPage({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          StoreCubit()..showStoreDataCubit(id: id),
      child: BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {},
        builder: (context, state) {
          StoreCubit storeCubit = StoreCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("Show Page"),
              backgroundColor: Colors.red,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.goNamed(RouterNamed.store);
                },
              ),
            ),
            body: (storeCubit.showProdect != null)
                ? ListView(children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: Image(
                            image: NetworkImage(
                                storeCubit.showProdect?.imageUrl ?? ""),
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                const Image(
                              image: AssetImage(
                                "assets/images/pic.jpeg",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: const Text(
                                            'Edit product',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          content: ProdectDialog(
                                              products:
                                                  storeCubit.showProdect));
                                    },
                                  ).then((value) => {
                                        storeCubit.showStoreDataCubit(
                                            id: storeCubit.showProdect?.id ?? 0)
                                      });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 30.0,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () async {
                                  await storeCubit.deleteStoreDataCubit(
                                      id: storeCubit.showProdect?.id ?? 0);
                                  context.goNamed(RouterNamed.store);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 30.0,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${storeCubit.showProdect?.name ?? "name"}",
                              style: const TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${storeCubit.showProdect?.description ?? "disc"}",
                              style: const TextStyle(
                                  fontSize: 15.0, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 25.0,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${storeCubit.showProdect?.id ?? 2}",
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                const Spacer(),
                                Text(
                                  "${storeCubit.showProdect?.price ?? 254} \$",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 20.0),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    (storeCubit.showProdect?.hasAttribute == true)
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                              "Attributes",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                            ),
                          )
                        : const SizedBox(),
                    (storeCubit.showProdect?.variations != null)
                        ? ListView.builder(
                          shrinkWrap: true,
                  
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              storeCubit.showProdect?.variations?.length ??
                                  0,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return showVariations(
                                name: storeCubit
                                    .showProdect?.variations?[index].name,
                                barcode: storeCubit.showProdect
                                    ?.variations?[index].barcode,
                                price: storeCubit
                                    .showProdect?.variations?[index].price,
                                stock: storeCubit
                                    .showProdect?.variations?[index].stock);
                          },
                        )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                  ])
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
