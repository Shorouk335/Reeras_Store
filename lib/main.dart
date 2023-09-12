import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/show.dart';
import 'package:reeras_store/modules/Prodects/Presentation/store.dart';

void main() {
  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyGlobalObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Reeras Store',
      routerConfig: _goRoute,
      builder: FlutterSmartDialog.init( 
        //عشان اعمل الديزاين الي عايز يظهر
          //default toast widget
          // toastBuilder: (String msg) => CustomToastWidget(msg: msg),
          //default loading widget
          // loadingBuilder: (String msg) => CustomLoadingWidget(msg: msg),
          ),
    );
  }

  final GoRouter _goRoute =
      GoRouter(initialLocation: RouterNamed.store, routes: [
    GoRoute(
        name: RouterNamed.store,
        path: "/",
        builder: (context, state) => const StorePage()),
    GoRoute(
        name: RouterNamed.show,
        path: "/show",
        builder: (context, state) => ShowPage(id: state.extra as int?)),
  ]);
}

class MyGlobalObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
