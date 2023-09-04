import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/cubit/cubit.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/cubit/states.dart';

class ShowPage extends StatelessWidget {
  int? id;
  ShowPage({required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ShowDataCubit()..showStoreDataCubit(id: this.id),
      child: BlocConsumer<ShowDataCubit, ShowDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          ShowDataCubit show_data_cubit = ShowDataCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Show Page"),
              backgroundColor: Colors.red,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.goNamed(RouterNamed.Store);
                },
              ),
            ),
            body: (show_data_cubit.showProdect != null)
                ? Padding(
                    padding: EdgeInsetsDirectional.all(7.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width ,
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
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Image(
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
                                      icon: Icon(
                                        Icons.edit,
                                        size: 25.0,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
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
                                    "${show_data_cubit.showProdect!.name}",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  Text(
                                    "${show_data_cubit.showProdect!.description}",
                                    style: TextStyle(
                                        fontSize: 8.0, color: Colors.grey),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 20.0,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${show_data_cubit.showProdect!.id}",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${show_data_cubit.showProdect!.price} \$",
                                        style: TextStyle(
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
                : Center(
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
