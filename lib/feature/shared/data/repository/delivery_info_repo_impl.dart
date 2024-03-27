import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/delivery_info_repo.dart';

class DeliveryInfoRepoImpl implements DeliveryInfoRepo {
  final ApiService _apiService;

  DeliveryInfoRepoImpl(this._apiService);
  @override

  /// Retrieves a list of [DeliveryInfoEntity] from the API service.
  ///
  /// Sends a GET request to the API service's '/allInfo' endpoint
  /// and handles the response accordingly. If the response status code
  /// is HttpStatus.ok (200), it returns a [DataSuccess] containing the retrieved
  /// data. Otherwise, it returns a [DataFailed] containing a [DioException]
  /// with relevant information.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type List<DeliveryInfoEntity>.
  @override
  Future<DataState<List<DeliveryInfoEntity>>> getAllInfo() async {
    try {
      // Sends a GET request to the API service's '/allInfo' endpoint and handles the response
      final httpResponse = await _apiService.getAllInfo();

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
    } on DioException catch (e) {
      // If there is any other exception, return a DataFailed object with the exception
      return DataFailed(e);
    }
  }
}
