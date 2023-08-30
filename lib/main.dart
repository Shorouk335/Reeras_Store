import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Edit/Presentaion/edit.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/Presentaion/show.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/Presentaion/store.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Reeras Store',
      routerConfig: _goRoute,
    );
  }

  GoRouter _goRoute = GoRouter(initialLocation: RouterNamed.Store, routes: [
    GoRoute(
        name: RouterNamed.Store,
        path: "/",
        builder: (context, state) => Store_Page()),
    GoRoute(
        name: RouterNamed.Show, path: "/show", builder: (context, state) {
        //int? id  = state.extra as int; // 👈 casting is important
       return Show_Page();

    }),
    GoRoute(
        name: RouterNamed.Edit,
        path: "/edit",
        builder: (context, state) => Edit_Page()),
  ]);
}
