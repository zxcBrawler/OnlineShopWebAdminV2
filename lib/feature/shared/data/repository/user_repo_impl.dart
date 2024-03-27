import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_edit_user_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/user_repository.dart';

class UserRepoImpl implements UserRepo {
  final ApiService _apiService;

  UserRepoImpl(this._apiService);

  @override

  /// Retrieves a list of [UserEntity] from the API service.
  ///
  /// This function sends a GET request to the API service's '/users' endpoint
  /// and handles the response accordingly. If the response status code is
  /// HttpStatus.ok (200), it returns a [DataSuccess] containing the retrieved
  /// data. Otherwise, it returns a [DataFailed] containing a [DioException]
  /// with relevant information.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type List<UserEntity>.
  Future<DataState<List<UserEntity>>> getAllUsers() async {
    try {
      // Sends a GET request to the API service's '/users' endpoint and handles the response
      final httpResponse = await _apiService.getUsers();

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

  /// Adds a [UserEntity] to the API service.
  ///
  /// This function sends a POST request to the API service's '/users' endpoint
  /// with the provided [user] data. It handles the response accordingly. If the
  /// response status code is HttpStatus.ok (200), it returns a [DataSuccess]
  /// containing the retrieved data. Otherwise, it returns a [DataFailed]
  /// containing a [DioException] with relevant information.
  ///
  /// Parameters:
  /// - [user]: The [UserDTO] object containing the data to be added.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type [UserEntity].
  Future<DataState<UserEntity>> addUser({UserDTO? user}) async {
    try {
      // Sends a POST request to the API service's '/users' endpoint with the provided user data and handles the response
      final httpResponse = await _apiService.addUser(
        gender: user!.gender,
        role: user.role,
        employeeNumber: user.employeeNumber,
        passwordHash: user.passwordHash,
        phoneNumber: user.phoneNumber,
        username: user.username,
        email: user.email,
        shopAddressId: user.shopAddressId,
      );

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
  Future<DataState<UserEntity>> updateUser({UserDTO? user}) async {
    try {
      final httpResponse = await _apiService.updateUserById(
        id: user!.id,
        gender: user.gender,
        role: user.role,
        employeeNumber: user.employeeNumber,
        phoneNumber: user.phoneNumber,
        username: user.username,
        email: user.email,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<void>> deleteUser({int? id}) async {
    try {
      final httpResponse = await _apiService.deleteUserById(
        id: id!,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
