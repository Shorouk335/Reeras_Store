import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/store_cubit.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class Prodect_Box extends StatefulWidget {
  Products? _product;
  Prodect_Box(Products product) {
    this._product = product;
  }

  @override
  State<Prodect_Box> createState() => _Prodect_BoxState(_product!);
}

class _Prodect_BoxState extends State<Prodect_Box> {
  Products? _product;
  _Prodect_BoxState(Products product) {
    this._product = product;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Store_Cubit(),
      child: BlocConsumer<Store_Cubit, Store_State>(
        listener: (context, state) {},
        builder: (context, state) {
          Store_Cubit store_cubit = Store_Cubit.get(context);
          return Padding(
            padding: EdgeInsetsDirectional.all(7.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                size: 25.0,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                store_cubit.Delete_Store_Data_Cubit(
                                    id: this._product!.id);
                              },
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${this._product!.name}",
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                          Text(
                            "${this._product!.description}",
                            style: TextStyle(fontSize: 8.0, color: Colors.grey),
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
                                "${this._product!.id}",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Spacer(),
                              Text(
                                "${this._product!.price} \$",
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
          );
        },
      ),
    );
  }
}
