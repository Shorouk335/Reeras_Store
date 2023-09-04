import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reeras_store/core/Router/router.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Show/Presentaion/show.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/Presentaion/store.dart';

void main() {
  BlocOverrides.runZoned(
        () {
      runApp( MyApp());
    },
    blocObserver: MyGlobalObserver(),
  );

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

  GoRouter _goRoute = GoRouter(initialLocation: RouterNamed.Store,
      routes: [
    GoRoute(
        name: RouterNamed.Store,
        path: "/",
        builder: (context, state) => StorePage()),
    GoRoute(
        name: RouterNamed.Show,
        path: "/show",
        builder: (context, state) => ShowPage(id: state.extra as int?)),
   ]
 );
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

