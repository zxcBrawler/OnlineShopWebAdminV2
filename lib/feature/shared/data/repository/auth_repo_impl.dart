import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_dto.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_responce.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService _apiService;

  AuthRepoImpl(this._apiService);

  @override

  /// Sends a login request to the API service and returns the result.
  ///
  /// Takes a [LoginDTO] object as a parameter. This object contains the
  /// username and password hash to be sent in the request.
  ///
  /// Returns a [DataState] object that can be of two types: [DataSuccess]
  /// or [DataFailed]. If the login is successful, [DataSuccess] is returned
  /// with the [LoginResponse] object. If there is an error, [DataFailed] is
  /// returned with a [DioException].
  Future<DataState<LoginResponse>> authorize({LoginDTO? loginDTO}) async {
    // Send a login request to the API service
    try {
      // The API service returns an HttpResponse object
      final httpResponse = await _apiService.login(
          username: loginDTO!.username!, passwordHash: loginDTO.passwordHash!);

      // If the status code of the HTTP response is 200 (OK)
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object with the LoginResponse data
        return DataSuccess(httpResponse.data);
      } else {
        // Return a DataFailed object with a DioException
        return DataFailed(DioException(
            // The error message from the server response
            message: httpResponse.data.message,
            // The status message from the HTTP response
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
  Future<DataState<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
