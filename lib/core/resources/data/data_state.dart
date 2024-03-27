import 'package:dio/dio.dart';

// Base class for all data states in the application that can be used to manage data state
abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

// when api request is successful
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

// when an error has occured
class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
