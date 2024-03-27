import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/employee_shop.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/employee_shop_repo.dart';

class EmployeeShopRepoImpl implements EmployeeShopRepo {
  final ApiService _apiService;

  EmployeeShopRepoImpl(this._apiService);

  @override

  /// Retrieves a list of [EmployeeShopEntity] from the API based on the provided shop
  /// [id]. If [id] is null, it returns an empry list.
  ///
  /// Returns a [DataState] object that can represent a successful state,
  /// a failed state, or a loading state.
  ///
  /// Throws a [DioException] if there was an error during the API call.
  Future<DataState<List<EmployeeShopEntity>>> getAllEmployeesFromShop(
      {int? id}) async {
    // Sends a GET request to the API service with the provided [id]
    try {
      final httpResponse = await _apiService.getAllEmployees(shopAddressId: id);

      // If the response status code is 200 OK, return a DataSuccess with the retrieved data
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
    // If there was an error during the API call, return a DataFailed with the exception
    on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override

  /// Retrieves an [EmployeeShopEntity] from the API based on the provided employee [id].
  /// If [id] is null, it returns a DataFailed state.
  ///
  /// Returns a [DataState] object that can represent a successful state,
  /// a failed state, or a loading state.
  ///
  /// Throws a [DioException] if there was an error during the API call.
  Future<DataState<EmployeeShopEntity>> getShopAddressByEmployeeId(
      {int? id}) async {
    // Sends a GET request to the API service with the provided employee [id]
    try {
      // The API service returns an HttpResponse object
      final httpResponse =
          await _apiService.getShopAddressByEmployeeId(employeeId: id);

      // If the status code of the HTTP response is 200 (OK)
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object with the retrieved EmployeeShopEntity data
        return DataSuccess(httpResponse.data);
      } else {
        // Otherwise, return a DataFailed object with a DioException containing relevant information
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
