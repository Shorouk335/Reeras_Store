
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/cubit/cubit.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/Presentaion/Widget.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/states.dart';

class Show_Page extends StatelessWidget {
   //int? id ;
   //Show_Page({required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Show_Data_Cubit()..Show_Store_Data_Cubit(id:107),
      child: BlocConsumer<Show_Data_Cubit,Show_Data_State>(
        listener:(context,state){} ,
        builder: (context,state){
          Show_Data_Cubit show_data_cubit = Show_Data_Cubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Show Page"),
              backgroundColor: Colors.red,
              leading: IconButton(
                icon: Icon(
                    Icons.arrow_back_ios
                ),
                onPressed: (){
                  context.goNamed(RouterNamed.Store);
                },
              ),
            ),
            body:  ConditionalBuilder(
            condition: show_data_cubit.show_Prodect != null,
            builder: (context) {
             return  Prodect_Box(show_data_cubit.show_Prodect!);
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ),
            ),
          );
        },

      ),
    );
  }
}
