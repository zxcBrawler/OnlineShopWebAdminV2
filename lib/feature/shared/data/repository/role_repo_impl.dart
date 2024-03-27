import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/model/role.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/role_repository.dart';

class RoleRepoImpl implements RoleRepo {
  final ApiService _apiService;

  RoleRepoImpl(this._apiService);

  @override

  /// Retrieves a list of [RoleModel] from the API service.
  ///
  /// This function sends a GET request to the API service's '/roles' endpoint
  /// and handles the response accordingly. If the response status code is
  /// HttpStatus.ok (200), it returns a [DataSuccess] containing the retrieved
  /// data. Otherwise, it returns a [DataFailed] containing a [DioException]
  /// with relevant information.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type List<RoleModel>.
  Future<DataState<List<RoleModel>>> getRoles() async {
    try {
      // Sends a GET request to the API service's '/roles' endpoint and handles the response
      final httpResponse = await _apiService.getRoles();

      // If the response status code is HttpStatus.ok (200), return a DataSuccess with the retrieved data
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
    }
    // If there is any other exception, return a DataFailed object with the exception
    on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
