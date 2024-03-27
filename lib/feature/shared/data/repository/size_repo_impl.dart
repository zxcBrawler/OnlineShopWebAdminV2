import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_size_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/size_repo.dart';

class SizeRepoImpl implements SizeRepo {
  final ApiService _apiService;

  SizeRepoImpl(this._apiService);

  @override

  /// Retrieves a list of [SizeClothesEntity] from the server.
  ///
  /// This function makes a request to the server using the [ApiService]
  /// and returns a [DataState] object. If the request is successful,
  /// a [DataSuccess] object is returned with the list of [SizeClothesEntity].
  /// If there is an error, a [DataFailed] object is returned with a
  /// [DioException] containing relevant information.
  Future<DataState<List<SizeClothesEntity>>> getSizes() async {
    // Try to retrieve all sizes from the server
    try {
      // The API service returns an HttpResponse object
      final httpResponse = await _apiService.getAllSizes();

      // If the status code of the HTTP response is 200 (OK)
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object with the list of SizeClothesEntity
        return DataSuccess(httpResponse.data);
      } else {
        // Return a DataFailed object with a DioException
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

  /// Adds a size to the server.
  ///
  /// This function makes a request to the server using the [ApiService]
  /// and returns a [DataState] object. If the request is successful,
  /// a [DataSuccess] object is returned with the added [SizeClothesEntity].
  /// If there is an error, a [DataFailed] object is returned with a
  /// [DioException] containing relevant information.
  ///
  /// The [size] parameter represents the size to be added.
  Future<DataState<SizeClothesEntity>> addSize({SizeDTO? size}) async {
    try {
      // Send a POST request to the server with the size name
      final httpResponse = await _apiService.addSize(nameSize: size!.nameSize);

      // If the status code of the HTTP response is 200 (OK)
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object with the added SizeClothesEntity
        return DataSuccess(httpResponse.data);
      } else {
        // Return a DataFailed object with a DioException
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
