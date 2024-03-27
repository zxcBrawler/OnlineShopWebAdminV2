import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_address_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_address_repo.dart';

class ShopAddressRepoImpl implements ShopAddressRepo {
  final ApiService _apiService;

  ShopAddressRepoImpl(this._apiService);
  @override

  /// Retrieves all shop addresses from the API service.
  ///
  /// Returns a [DataState] object that represents the result of the operation.
  /// If the operation is successful, the [DataState] will contain a list of
  /// [ShopAddressEntity] objects. If the operation fails, the [DataState] will
  /// contain a [DioException] object with the error details.
  Future<DataState<List<ShopAddressEntity>>> getAllShopAddresses() async {
    // Sends a GET request to the API service's '/shopAddresses' endpoint and
    // handles the response.
    try {
      final httpResponse = await _apiService.getShopAddresses();

      // If the response status code is HttpStatus.ok (200), return a DataSuccess
      // with the retrieved data.
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        // Otherwise, return a DataFailed with a DioException containing
        // relevant information.
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      // If there is any other exception, return a DataFailed object with the
      // exception.
      return DataFailed(e);
    }
  }

  @override

  /// Deletes a shop address from the API service by its [id].
  ///
  /// Takes an [id] of type [int] which is the unique identifier of the shop address.
  /// Returns a [DataState] object. If the operation is successful, the [DataState]
  /// will contain a [void] object. If the operation fails, the [DataState] will
  /// contain a [DioException] object with the error details.
  ///
  /// Throws a [DioException] if there is any other exception.
  Future<DataState<void>> deleteAddress(int? id) async {
    // Sends a DELETE request to the API service's '/shopAddresses/{id}' endpoint
    // and handles the response.
    try {
      // The API service returns an HttpResponse object
      final httpResponse = await _apiService.deleteShopAddressById(id: id!);

      // If the status code of the HTTP response is 200 (OK)
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess object with a void data
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

  /// Adds a new shop address to the API service.
  /// Sends a POST request to the API service's '/shopAddresses' endpoint with
  /// the shop address data and handles the response.
  ///
  /// Takes a [shopAddressDTO] of type [ShopAddressDTO] which contains the data
  /// for the new shop address. Returns a [DataState] object. If the operation
  /// is successful, the [DataState] will contain a [ShopAddressEntity] object.
  /// If the operation fails, the [DataState] will contain a [DioException] object
  /// with the error details.
  ///
  /// Throws a [DioException] if there is any other exception.
  Future<DataState<ShopAddressEntity>> addShopAddress(
      {ShopAddressDTO? shopAddressDTO}) async {
    try {
      final httpResponse = await _apiService.addShopAddress(
          shopMetro: shopAddressDTO!.shopMetro!,
          shopAddressDirection: shopAddressDTO.shopAddressDirection!,
          contactNumber: shopAddressDTO.contactNumber!,
          latitude: shopAddressDTO.latitude!,
          longitude: shopAddressDTO.longitude!);

      // If the response status code is HttpStatus.ok (200), return a DataSuccess
      // with the retrieved data.
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        // Otherwise, return a DataFailed with a DioException containing
        // relevant information.
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      // If there is any other exception, return a DataFailed object with the
      // exception.
      return DataFailed(e);
    }
  }

  @override

  /// Updates a shop address in the API service.
  ///
  /// Takes a [shopAddressDTO] object of type [ShopAddressDTO] which
  /// contains the updated shop address details. Returns a [DataState]
  /// object that represents the result of the operation. If the operation
  /// is successful, the [DataState] will contain the updated [ShopAddressEntity]
  /// object. If the operation fails, the [DataState] will contain a
  /// [DioException] object with the error details.
  ///
  /// Throws a [DioException] if there is any other exception.
  Future<DataState<ShopAddressEntity>> updateShopAddress(
      {ShopAddressDTO? shopAddressDTO}) async {
    try {
      // Sends a PUT request to the API service's '/shopAddresses/{id}' endpoint
      // with the updated shop address details and handles the response.
      final httpResponse = await _apiService.updateShopAddress(
          shopMetro: shopAddressDTO!.shopMetro!,
          shopAddressDirection: shopAddressDTO.shopAddressDirection!,
          contactNumber: shopAddressDTO.contactNumber!,
          latitude: shopAddressDTO.latitude!,
          longitude: shopAddressDTO.longitude!,
          id: shopAddressDTO.shopAddressesId!);

      // If the response status code is HttpStatus.ok (200), return a DataSuccess
      // with the updated data.
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        // Otherwise, return a DataFailed with a DioException containing
        // relevant information.
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      // If there is any other exception, return a DataFailed object with the
      // exception.
      return DataFailed(e);
    }
  }
}
