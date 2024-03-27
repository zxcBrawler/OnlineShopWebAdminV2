import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_color_dto.dart';
import 'package:xc_web_admin/feature/shared/data/model/color.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/color_repo.dart';

class ColorRepoImpl implements ColorRepo {
  final ApiService _apiService;

  ColorRepoImpl(this._apiService);

  @override

  /// Retrieves a list of [ColorEntity] from the API service.
  ///
  /// This function sends a GET request to the API service's '/allColors' endpoint
  /// and handles the response accordingly. If the response status code is
  /// HttpStatus.ok (200), it returns a [DataSuccess] containing the retrieved
  /// data. Otherwise, it returns a [DataFailed] containing a [DioException]
  /// with relevant information.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type List<ColorEntity>.
  Future<DataState<List<ColorEntity>>> getColors() async {
    try {
      // Sends a GET request to the API service's '/allColors' endpoint and handles the response
      final httpResponse = await _apiService.getAllColors();

      // If the response status code is HttpStatus.ok (200), return a DataSuccess with the retrieved data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      // Otherwise, return a DataFailed with a DioException containing relevant information
      else {
        return DataFailed(DioException(
            error: httpResponse.response
                .statusMessage, // The error message from the server response
            response: httpResponse.response, // The HTTP response object
            type: DioExceptionType.badResponse, // The type of exception
            requestOptions: httpResponse.response
                .requestOptions)); // The request options used for the HTTP request
      }
    } on DioException catch (e) {
      // If there is any other exception, return a DataFailed object with the exception
      return DataFailed(e);
    }
  }

  @override

  /// Sends a POST request to the API service to add a color.
  ///
  /// Takes a [ColorDTO] object as a parameter. This object contains the
  /// name and hex code of the color to be added.
  ///
  /// Returns a [DataState] object that can be of two types: [DataSuccess]
  /// or [DataFailed]. If the add color request is successful, [DataSuccess]
  /// is returned with the [ColorModel] object. If there is an error,
  /// [DataFailed] is returned with a [DioException].
  Future<DataState<ColorModel>> addColor({ColorDTO? color}) async {
    try {
      // Send a POST request to the API service to add a color
      final httpResponse = await _apiService.addColor(
          nameColor: color!.nameColor, // The name of the color
          hex: color.hex // The hex code of the color
          );

      // If the status code of the HTTP response is 200 (OK)
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object with the ColorModel data
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
