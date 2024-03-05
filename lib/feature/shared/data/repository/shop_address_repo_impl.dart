import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_address_repo.dart';

class ShopAddressRepoImpl implements ShopAddressRepo {
  final ApiService _apiService;

  ShopAddressRepoImpl(this._apiService);
  @override
  Future<DataState<List<ShopAddressEntity>>> getAllShopAddresses() async {
    try {
      final httpResponse =
          await _apiService.getShopAddresses(accessToken: accessToken!);
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
  Future<DataState<void>> deleteAddress(int? id) async {
    try {
      final httpResponse = await _apiService.deleteShopAddressById(
          id: id!, accessToken: accessToken!);
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
