import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/order_comp_repo.dart';

class OrderCompRepoImpl implements OrderCompRepo {
  final ApiService _apiService;

  OrderCompRepoImpl(this._apiService);

  @override

  /// Retrieves the order composition from the API service.
  ///
  /// This function makes a GET request to the '/ordersComp' endpoint of the API service.
  /// If the response status code is 200 (OK), it returns a [DataSuccess] object with the retrieved data.
  /// Otherwise, it returns a [DataFailed] object with a [DioException] containing relevant information.
  /// If any exception occurs during the process, it returns a [DataFailed] object with the exception.
  Future<DataState<List<OrderCompositionEntity>>> getOrderComposition() async {
    try {
      // Sends a GET request to the '/ordersComp' endpoint
      final httpResponse = await _apiService.getOrdersComp();

      // If the response status code is 200, return a DataSuccess with the retrieved data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      // Otherwise, return a DataFailed with a DioException containing relevant information
      else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    }
    // If any exception occurs, return a DataFailed object with the exception
    on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override

  /// Retrieves the order composition for a specific order by its [id].
  ///
  /// This function sends a GET request to the '/ordersComp' endpoint of the API
  /// service with the specified [id] to retrieve the order composition.
  /// If the response status code is 200 (OK), it returns a [DataSuccess] object
  /// with the retrieved data. Otherwise, it returns a [DataFailed] object
  /// with a [DioException] containing relevant information.
  /// If any exception occurs during the process, it returns a [DataFailed]
  /// object with the exception.
  Future<DataState<List<OrderCompositionEntity>>> getOrderCompositionByOrderId(
      {int? id}) async {
    try {
      // Sends a GET request to the '/ordersComp' endpoint with the specified order id
      final httpResponse = await _apiService.getOrdersCompByOrderId(id: id);

      // If the response status code is 200, return a DataSuccess with the retrieved data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      // Otherwise, return a DataFailed with a DioException containing relevant information
      else {
        return DataFailed(DioException(
            // The error message from the server response
            error: httpResponse.response.statusMessage,
            // The HTTP response object
            response: httpResponse.response,
            // The type of exception
            type: DioExceptionType.badResponse,
            // The request options used for the HTTP request
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      // If there is any other exception, return a DataFailed object with the exception
      return DataFailed(e);
    }
  }
}
