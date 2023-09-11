import 'package:dio/dio.dart';

abstract class StoreState {}

class InitialStoreDataState extends StoreState {}
//geeeet

class LoadingStoreDataState extends StoreState {}

class SuccessfulGetStoreDataState extends StoreState {}

class ErrorGetStoreDataState extends StoreState {
  final DioException? error;
  ErrorGetStoreDataState({this.error});
}

//delete
class LoadingDeleteStoreDataState extends StoreState {}

class SuccessfulDeleteStoreDataState extends StoreState {}

class ErrorDeleteStoreDataState extends StoreState {}

//poooost
class LoadingPostStoreDataState extends StoreState {}

class SuccessfulPostProdectState extends StoreState {}

class ErrorPostStoreDataState extends StoreState {
  final DioException? error;
  ErrorPostStoreDataState({this.error});
}

//edit
class LoadingEditStoreDataState extends StoreState {}

class SuccefulEditDataState extends StoreState {}

class ErrorEditStoreDataState extends StoreState {}
