import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/model/category_clothes.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/gender_repository.dart';

class GenderRepoImpl implements GenderRepo {
  final ApiService _apiService;

  GenderRepoImpl(this._apiService);
  @override

  /// Retrieves a list of [CategoryClothesModel] from the API service.
  ///
  /// This function sends a GET request to the API service's '/getGenders'
  /// endpoint and handles the response accordingly. If the response status
  /// code is HttpStatus.ok (200), it returns a [DataSuccess] containing the
  /// retrieved data. Otherwise, it returns a [DataFailed] containing a
  /// [DioException] with relevant information.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type
  /// List<CategoryClothesModel>.
  Future<DataState<List<CategoryClothesModel>>> getGenders() async {
    try {
      // Sends a GET request to the API service's '/getGenders' endpoint and
      // handles the response
      final httpResponse = await _apiService.getGenders();

      // If the response status code is HttpStatus.ok (200), return a DataSuccess
      // with the retrieved data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      // Otherwise, return a DataFailed with a DioException containing
      // relevant information
      else {
        return DataFailed(DioException(
            error: httpResponse.response
                .statusMessage, // The error message from the server response
            response: httpResponse.response, // The HTTP response object
            type: DioExceptionType.badResponse, // The type of exception
            requestOptions: httpResponse.response
                .requestOptions)); // The request options used for the HTTP request
      }
    }
    // If there is any other exception, return a DataFailed object with the exception
    on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
