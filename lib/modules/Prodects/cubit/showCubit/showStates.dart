import 'package:dio/dio.dart';

abstract class ShowDataState {}
class InitialShowState extends ShowDataState{}
class  GetShowState extends ShowDataState{}
class  LoadingShowState extends ShowDataState{}
class  ErrorShowState extends ShowDataState{ 
 DioException error ;
  ErrorShowState({ required this.error});
}
