import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/edit_status_dto.dart';
import 'package:xc_web_admin/feature/shared/data/model/status_order.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/status_repo.dart';

class StatusRepoImpl implements StatusRepo {
  final ApiService _apiService;

  StatusRepoImpl(this._apiService);

  @override

  /// Retrieves a list of [StatusOrderModel] from the API service.
  ///
  /// This function sends a GET request to the API service's `/statuses` endpoint.
  /// If the request is successful (status code 200), it returns a [DataSuccess]
  /// object containing the list of [StatusOrderModel]. Otherwise, it returns a
  /// [DataFailed] object with a [DioException] containing relevant information.
  /// If an exception occurs, it returns a [DataFailed] object with the exception.
  ///
  /// Returns a [Future] that resolves to a [DataState] object.
  Future<DataState<List<StatusOrderModel>>> getStatuses() async {
    try {
      // Send a GET request to the API service's `/statuses` endpoint
      final httpResponse = await _apiService.getStatuses();

      // If the response status code is 200 (OK)
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object with the list of StatusOrderModel
        return DataSuccess(httpResponse.data);
      } else {
        // Return a DataFailed object with a DioException containing relevant information
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

  @override

  /// Updates the status of a order.
  ///
  /// This function sends a PUT request to the API service's `/statuses/{id}`
  /// endpoint with a [StatusDTO] object containing the updated status ID.
  /// If the request is successful (status code 200), it returns a [DataSuccess]
  /// object. Otherwise, it returns a [DataFailed] object with a [DioException]
  /// containing relevant information. If an exception occurs, it returns a
  /// [DataFailed] object with the exception.
  ///
  /// Parameters:
  /// - [statusDTO] - An optional [StatusDTO] object containing the updated
  /// status ID. If not provided, it defaults to null.
  ///
  /// Returns a [Future] that resolves to a [DataState] object.
  Future<DataState<void>> updateStatus({StatusDTO? statusDTO}) async {
    // Send a PUT request to the API service's `/statuses/{id}` endpoint
    try {
      final httpResponse = await _apiService.updateStatus(
        id: statusDTO!.id,
        statusID: statusDTO.statusID,
      );

      // If the response status code is 200 (OK)
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object
        return DataSuccess(httpResponse.data);
      } else {
        // Return a DataFailed object with a DioException containing relevant information
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
