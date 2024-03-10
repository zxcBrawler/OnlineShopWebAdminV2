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
  Future<DataState<List<ClothesEntity>>> getClothes() async {
    try {
      final httpResponse = await _apiService.getClothes();
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
  Future<DataState<List<ClothesColorsEntity>>> getClothesColors(
      {int? id}) async {
    try {
      final httpResponse = await _apiService.getColors(
        id: id,
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
  Future<DataState<List<ClothesSizeClothesEntity>>> getClothesSizeClothes(
      {int? id}) async {
    try {
      final httpResponse = await _apiService.getSizes(id: id);
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
  Future<DataState<List<PhotosOfClothesEntity>>> getPhotosOfClothes(
      {int? id}) async {
    try {
      final httpResponse = await _apiService.getPhotos(id: id);
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
  Future<DataState<ClothesEntity>> addClothes({ClothesDTO? clothesDTO}) async {
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
  Future<DataState<List<TypeClothesEntity>>> getTypeClothes({int? id}) async {
    try {
      final httpResponse = await _apiService.getTypeClothes(id: id);
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
