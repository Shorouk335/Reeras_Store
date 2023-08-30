import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/Presentaion/Widget.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/store_cubit.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/domain/repository/repository.dart';

class Store_Page extends StatefulWidget {
  const Store_Page({super.key});
  @override
  State<Store_Page> createState() => _Store_PageState();
}

class _Store_PageState extends State<Store_Page> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          Store_Cubit()..Get_Store_Data_Cubit(PageName: 1),
      child: BlocConsumer<Store_Cubit, Store_State>(
        listener: (context, state) {},
        builder: (context, state) {
          Store_Cubit store_cubit = Store_Cubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Reeras Store"),
              backgroundColor: Colors.red,
            ),
            body: SingleChildScrollView(
              child: GridView.count(
                crossAxisCount: 2,
                scrollDirection: Axis.vertical,
                mainAxisSpacing: 2,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children:
                List.generate(store_cubit.Store_Data_List.length, (index) {
                  return InkWell(
                      onTap:(){
                        context.goNamed(RouterNamed.Show );
                        // ,queryParameters: {"id" : this._product!.id}
                      },
                      child: Prodect_Box(store_cubit.Store_Data_List[index]));
                }),


              ),
            ),
            // GridView.builder(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2, // number of items in each row
            //       mainAxisSpacing: 8.0, // spacing between rows
            //       crossAxisSpacing: 8.0, // spacing between columns
            //     ),
            //     //  padding: EdgeInsets.all(8.0), // padding around the grid
            //     itemCount: store_cubit.Store_Data_List.length,
            //     // total number of items
            //     itemBuilder: (context, index) {
            //       return Prodect_Box(store_cubit.Store_Data_List[index]);
            //     }

          );
        },
      ),
    );
  }
}
