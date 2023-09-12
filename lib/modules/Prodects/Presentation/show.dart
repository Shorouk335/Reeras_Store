import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/cubit/showCubit/showCubit.dart';
import 'package:reeras_store/modules/Prodects/cubit/showCubit/showStates.dart';

// ignore: must_be_immutable
class ShowPage extends StatelessWidget {
  int? id;
  ShowPage({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ShowDataCubit()..showStoreDataCubit(id: id),
      child: BlocConsumer<ShowDataCubit, ShowDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          ShowDataCubit showDataCubit = ShowDataCubit.get(context);
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
            body: (showDataCubit.showProdect != null)
                ? Padding(
                    padding: EdgeInsetsDirectional.all(7.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(children: [
                        Expanded(
                          flex: 2,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: const Image(
                                  image: AssetImage(
                                    "assets/images/pic.jpeg",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 25.0,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 25.0,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${showDataCubit.showProdect!.name}",
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  Text(
                                    "${showDataCubit.showProdect!.description}",
                                    style: const TextStyle(
                                        fontSize: 8.0, color: Colors.grey),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 20.0,
                                        color: Colors.yellow,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${showDataCubit.showProdect!.id}",
                                        style: const TextStyle(fontSize: 15.0),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${showDataCubit.showProdect!.price} \$",
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ]),
                    ),
                  )
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
