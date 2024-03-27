import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_garnish_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_garnish_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_garnish_repo.dart';

class ShopGarnishRepoImpl implements ShopGarnishRepo {
  final ApiService _apiService;
  ShopGarnishRepoImpl(this._apiService);

  @override

  /// Retrieves a list of [ShopGarnishEntity] objects for a specific shop address
  ///
  /// Takes an optional [id] parameter for the shop address id
  /// Returns a [DataState] object which can be either a [DataSuccess]
  /// containing the retrieved [List] of [ShopGarnishEntity] or a [DataFailed]
  /// containing a [DioException]
  Future<DataState<List<ShopGarnishEntity>>> getShopGarnish({int? id}) async {
    // Sends a GET request to the API service's '/getShopGarnish' endpoint
    // with the provided [id] parameter
    try {
      final httpResponse = await _apiService.getShopGarnish(shopAddressId: id);

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

  @override

  /// Updates the quantity of a shop garnish.
  ///
  /// Takes a [ShopGarnishDTO] object as a parameter which contains the shop
  /// garnish id and the new quantity. Returns a [DataState] object which can
  /// be either a [DataSuccess] containing void or a [DataFailed] containing a
  /// [DioException].
  ///
  /// Throws a [DioException] if there are any other exceptions.
  Future<DataState<void>> updateQuantity(
      {ShopGarnishDTO? shopGarnishDTO}) async {
    // Sends a PUT request to the API service's '/updateQuantity' endpoint with
    // the provided shop garnish id and the new quantity
    try {
      final httpResponse = await _apiService.updateQuantity(
        shopGarnishId: shopGarnishDTO!.shopGarnishId,
        quantity: shopGarnishDTO.quantity,
      );

      // If the response status code is HttpStatus.ok (200), return a DataSuccess
      // with void
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      // Otherwise, return a DataFailed with a DioException containing relevant
      // information
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

  @override

  /// Adds a new shop garnish to the database.
  ///
  /// Takes a [ShopGarnishDTO] object as a parameter.
  ///
  /// Returns a [DataState] object which can be either a [DataSuccess]
  /// containing a [ShopGarnishEntity] or a [DataFailed] containing a
  /// [DioException].
  ///
  /// Throws a [DioException] if there are any other exceptions.
  ///
  /// The [ShopGarnishDTO] object should contain the necessary information
  /// to create a new shop garnish, including size clothes id, color clothes id,
  /// shop id, and quantity.
  Future<DataState<ShopGarnishEntity>> addShopGarnish(
      {ShopGarnishDTO? shopGarnishDTO}) async {
    // Sends a POST request to the API service's '/addShopGarnish' endpoint with
    // the provided shop garnish information
    try {
      final httpResponse = await _apiService.addShopGarnish(
          sizeClothesId: shopGarnishDTO!.sizeClothesId,
          colorClothesId: shopGarnishDTO.colorClothesId,
          shopId: shopGarnishDTO.shopId,
          quantity: shopGarnishDTO.quantity);

      // If the response status code is HttpStatus.ok (200), return a DataSuccess with the new shop garnish
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      // Otherwise, return a DataFailed with a DioException containing relevant
      // information
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

  @override

  /// Deletes a shop garnish with the specified [id].
  ///
  /// This function sends a DELETE request to the API service's
  /// '/deleteShopGarnishById' endpoint with the provided [id].
  ///
  /// Returns a [DataState] object which can be either a [DataSuccess]
  /// containing void on success or a [DataFailed] containing a [DioException]
  /// on failure.
  Future<DataState<void>> deleteShopGarnish({int? id}) async {
    try {
      // Send a DELETE request to the API service
      final httpResponse = await _apiService.deleteShopGarnishById(id: id);

      // Check the status code of the response
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        // Return a DataSuccess with void if the status code is OK (200)
        return DataSuccess(httpResponse.data);
      } else {
        // Return a DataFailed with a DioException containing relevant information
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      // Return a DataFailed object with the exception if there is any other exception
      return DataFailed(e);
    }
  }
}
