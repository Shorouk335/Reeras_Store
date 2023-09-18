import 'package:dio/dio.dart';

abstract class StoreState {}

class InitialStoreDataState extends StoreState {}

class LoadingStoreDataState extends StoreState {}

class SuccessfulGetStoreDataState extends StoreState {}

class ErrorGetStoreDataState extends StoreState {
  DioException error;
  ErrorGetStoreDataState({required this.error});
}

class LoadingShowState extends StoreState {}

class GetShowState extends StoreState {}

class ErrorShowState extends StoreState {
  DioException error;
  ErrorShowState({required this.error});
}

class LoadingDeleteStoreDataState extends StoreState {}

class SuccessfulDeleteStoreDataState extends StoreState {
  String? msg;
  SuccessfulDeleteStoreDataState({required this.msg});
}

class ErrorDeleteStoreDataState extends StoreState {
  DioException error;
  ErrorDeleteStoreDataState({required this.error});
}

class LoadingPostStoreDataState extends StoreState {}

class SuccessfulPostProdectState extends StoreState {
  String? msg;
  SuccessfulPostProdectState({required this.msg});
}

class ErrorPostStoreDataState extends StoreState {
  DioException error;
  ErrorPostStoreDataState({required this.error});
}

class LoadingEditStoreDataState extends StoreState {}

class SuccefulEditDataState extends StoreState {
  String? msg;
  SuccefulEditDataState({required this.msg});
}

class ErrorEditStoreDataState extends StoreState {
  DioException error;
  ErrorEditStoreDataState({required this.error});
}
