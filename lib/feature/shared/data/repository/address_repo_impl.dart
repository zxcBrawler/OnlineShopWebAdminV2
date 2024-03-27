import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/address_repo.dart';

class AddressRepoImpl implements AddressRepo {
  final ApiService _apiService;

  AddressRepoImpl(this._apiService);
  @override

  /// Retrieves a list of all addresses from the API.
  ///
  /// This function sends a GET request to the `/addresses` endpoint of the API.
  /// If the request is successful (status code 200), it returns a [DataSuccess]
  /// object containing the list of [AddressEntity]. Otherwise, it returns a
  /// [DataFailed] object containing a [DioException] with the appropriate error
  /// information.
  ///
  /// Returns a [Future] of type [DataState<List<AddressEntity>>].
  Future<DataState<List<AddressEntity>>> getAllAddresses() async {
    // Send a GET request to the `/addresses` endpoint of the API
    try {
      final httpResponse = await _apiService.getAddresses();

      // Check if the request was successful
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object containing the list of AddressEntity
        return DataSuccess(httpResponse.data);
      } else {
        // Return a DataFailed object containing a DioException with the appropriate error information
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      // Return a DataFailed object containing the caught DioException
      return DataFailed(e);
    }
  }

  @override

  /// Retrieves a list of [UserAddressEntity] by its id from the API.
  ///
  /// This function sends a GET request to the `/addresses/{id}` endpoint of the API.
  /// If the request is successful (status code 200), it returns a [DataSuccess]
  /// object containing the list of [UserAddressEntity]. Otherwise, it returns a
  /// [DataFailed] object containing a [DioException] with the appropriate error
  /// information.
  ///
  /// Parameters:
  /// - [id] (optional) - The id of the address to retrieve.
  ///
  /// Returns a [Future] of type [DataState<List<UserAddressEntity>>].
  Future<DataState<List<UserAddressEntity>>> getAddressById({int? id}) async {
    // Send a GET request to the `/addresses/{id}` endpoint of the API
    try {
      // Make the GET request to retrieve the UserAddressEntity by id
      final httpResponse = await _apiService.getAddressesById(id: id);

      // Check if the request was successful
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object containing the list of UserAddressEntity
        return DataSuccess(httpResponse.data);
      } else {
        // Return a DataFailed object containing a DioException with the appropriate error information
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      // Return a DataFailed object containing the caught DioException
      return DataFailed(e);
    }
  }
}
