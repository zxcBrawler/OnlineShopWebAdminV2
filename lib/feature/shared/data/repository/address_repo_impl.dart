import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/address_repo.dart';

class AddressRepoImpl implements AddressRepo {
  final ApiService _apiService;

  AddressRepoImpl(this._apiService);
  @override
  Future<DataState<List<AddressEntity>>> getAllAddresses() async {
    try {
      final httpResponse =
          await _apiService.getAddresses(accessToken: accessToken!);
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
  Future<DataState<AddressEntity>> getAddressById({int? id}) async {
    try {
      final httpResponse = await _apiService.getAddressesById(
          idAddress: id, accessToken: accessToken!);
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
