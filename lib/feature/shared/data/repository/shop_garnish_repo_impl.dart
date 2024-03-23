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
  Future<DataState<List<ShopGarnishEntity>>> getShopGarnish({int? id}) async {
    try {
      final httpResponse = await _apiService.getShopGarnish(shopAddressId: id);
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
  Future<DataState<void>> updateQuantity(
      {ShopGarnishDTO? shopGarnishDTO}) async {
    try {
      final httpResponse = await _apiService.updateQuantity(
        shopGarnishId: shopGarnishDTO!.shopGarnishId,
        quantity: shopGarnishDTO.quantity,
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
  Future<DataState<ShopGarnishEntity>> addShopGarnish(
      {ShopGarnishDTO? shopGarnishDTO}) async {
    try {
      final httpResponse = await _apiService.addShopGarnish(
          sizeClothesId: shopGarnishDTO!.sizeClothesId,
          colorClothesId: shopGarnishDTO.colorClothesId,
          shopId: shopGarnishDTO.shopId,
          quantity: shopGarnishDTO.quantity);
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
  Future<DataState<void>> deleteShopGarnish({int? id}) async {
    try {
      final httpResponse = await _apiService.deleteShopGarnishById(id: id);
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
