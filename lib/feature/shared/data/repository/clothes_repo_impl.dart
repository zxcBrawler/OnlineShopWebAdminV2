import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_clothes_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_colors_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/photos_of_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/type_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/clothes_repo.dart';

class ClothesRepoImpl implements ClothesRepo {
  final ApiService _apiService;

  ClothesRepoImpl(this._apiService);

  @override

  /// Retrieves a list of [ClothesEntity] from the API service.
  ///
  /// This function sends a GET request to the API service's '/clothes' endpoint
  /// and handles the response accordingly. If the response status code is
  /// HttpStatus.ok (200), it returns a [DataSuccess] containing the retrieved
  /// data. Otherwise, it returns a [DataFailed] containing a [DioException]
  /// with relevant information.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type List<ClothesEntity>.
  Future<DataState<List<ClothesEntity>>> getClothes() async {
    // Sends a GET request to the API service's '/clothes' endpoint and handles the response
    try {
      final httpResponse = await _apiService.getClothes();

      // If the response status code is HttpStatus.ok (200), return a DataSuccess with the retrieved data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      // Otherwise, return a DataFailed with a DioException containing relevant information
      else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    }

    // If there is a DioException, return a DataFailed with the caught exception
    on DioException catch (e) {
      return DataFailed(e);
    }
  }

  /// Retrieves a list of [ClothesColorsEntity] from the API service.
  ///
  /// This function sends a GET request to the API service's '/clothes/colors' endpoint
  /// with an optional parameter 'id'. If the 'id' parameter is provided, it sends a
  /// request to the API service's '/clothes/colors/{id}' endpoint.
  ///
  /// The function handles the response accordingly. If the response status code is
  /// HttpStatus.ok (200), it returns a [DataSuccess] containing the retrieved data.
  /// Otherwise, it returns a [DataFailed] containing a [DioException] with relevant
  /// information.
  ///
  /// Parameters:
  /// - id (optional): An integer representing the id of the clothes.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type List<ClothesColorsEntity>.
  @override
  Future<DataState<List<ClothesColorsEntity>>> getClothesColors(
      {int? id}) async {
    // Sends a GET request to the API service's '/clothes/colors' endpoint or
    // '/clothes/colors/{id}' endpoint based on the provided parameter 'id'
    try {
      final httpResponse = await _apiService.getColors(
        id: id,
      );

      // If the response status code is HttpStatus.ok (200), return a DataSuccess with the retrieved data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      // Otherwise, return a DataFailed with a DioException containing relevant information
      else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    }

    // If there is a DioException, return a DataFailed with the caught exception
    on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override

  /// Retrieves a list of [ClothesSizeClothesEntity] from the API service.
  ///
  /// Sends a GET request to the API service's '/sizes' endpoint or
  /// '/sizes/{id}' endpoint based on the provided parameter 'id'.
  /// If the response status code is HttpStatus.ok (200), it returns a [DataSuccess]
  /// containing the retrieved data. Otherwise, it returns a [DataFailed] with
  /// a [DioException] containing relevant information.
  ///
  /// Parameters:
  /// - id (optional): An integer representing the id of the clothes.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type List<ClothesSizeClothesEntity>.
  Future<DataState<List<ClothesSizeClothesEntity>>> getClothesSizeClothes(
      {int? id}) async {
    try {
      // Send a GET request to the API service's '/sizes' endpoint or
      // '/sizes/{id}' endpoint based on the provided parameter 'id'
      final httpResponse = await _apiService.getSizes(id: id);

      // If the response status code is HttpStatus.ok (200),
      // return a DataSuccess with the retrieved data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      // Otherwise, return a DataFailed with a DioException containing relevant information
      else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      // If there is a DioException, return a DataFailed with the caught exception
      return DataFailed(e);
    }
  }

  @override

  /// Retrieves a list of [PhotosOfClothesEntity] from the API service.
  ///
  /// Sends a GET request to the API service's '/photos' endpoint or
  /// '/photos/{id}' endpoint based on the provided parameter 'id'.
  /// If the response status code is HttpStatus.ok (200), it returns a [DataSuccess]
  /// containing the retrieved data. Otherwise, it returns a [DataFailed] with
  /// a [DioException] containing relevant information.
  ///
  /// Parameters:
  /// - [id] (optional): The id parameter of the clothes to fetch photos for.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type List<PhotosOfClothesEntity>.
  Future<DataState<List<PhotosOfClothesEntity>>> getPhotosOfClothes(
      {int? id}) async {
    // Sends a GET request to the API service's '/photos' endpoint or
    // '/photos/{id}' endpoint based on the provided parameter 'id'
    try {
      final httpResponse = await _apiService.getPhotos(id: id);

      // If the response status code is HttpStatus.ok (200), return a DataSuccess with the retrieved data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      // Otherwise, return a DataFailed with a DioException containing relevant information
      else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      // If there is a DioException, return a DataFailed with the caught exception
      return DataFailed(e);
    }
  }

  @override

  /// Adds clothes to the API service.
  ///
  /// Sends a POST request to the API service's '/clothes' endpoint with the provided
  /// clothesDTO containing information about the clothes to be added. If the
  /// response status code is HttpStatus.ok (200), it returns a [DataSuccess]
  /// containing the added clothes data. Otherwise, it returns a [DataFailed]
  /// with a [DioException] containing relevant information.
  ///
  /// Parameters:
  /// - [clothesDTO] (optional): The clothesDTO containing the information about the
  /// clothes to be added.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type ClothesEntity.
  Future<DataState<ClothesEntity>> addClothes({ClothesDTO? clothesDTO}) async {
    // Sends a POST request to the API service's '/clothes' endpoint with the provided
    // clothesDTO containing information about the clothes to be added
    try {
      final httpResponse = await _apiService.addClothes(
        selectedTypeClothes: clothesDTO!.selectedTypeClothes,
        nameClothesRu: clothesDTO.nameClothesRu,
        nameClothesEn: clothesDTO.nameClothesEn,
        barcode: clothesDTO.barcode,
        priceClothes: clothesDTO.priceClothes,
        selectedSizes: clothesDTO.selectedSizes,
        selectedColors: clothesDTO.selectedColors,
        uploadedPhotos: clothesDTO.uploadedPhotos,
      );

      // If the response status code is HttpStatus.ok (200), return a DataSuccess with the added data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      // Otherwise, return a DataFailed with a DioException containing relevant information
      else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    }

    // If there is a DioException, return a DataFailed with the caught exception
    on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override

  /// Retrieves a list of [TypeClothesEntity] from the API service.
  ///
  /// This function sends a GET request to the API service's '/clothes/types' endpoint
  /// or '/clothes/types/{id}' endpoint based on the provided parameter 'id'.
  ///
  /// Parameters:
  /// - [id] (optional): The ID of the specific type of clothes to retrieve.
  ///
  /// Returns a [Future] that resolves to a [DataState] of type List<TypeClothesEntity>.
  Future<DataState<List<TypeClothesEntity>>> getTypeClothes({int? id}) async {
    // Sends a GET request to the API service's '/clothes/types' endpoint or
    // '/clothes/types/{id}' endpoint based on the provided parameter 'id'
    try {
      final httpResponse = await _apiService.getTypeClothes(id: id);

      // If the response status code is HttpStatus.ok (200), return a DataSuccess with the retrieved data
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      // Otherwise, return a DataFailed with a DioException containing relevant information
      else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    }

    // If there is a DioException, return a DataFailed with the caught exception
    on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
