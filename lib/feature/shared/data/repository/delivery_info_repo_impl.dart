import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/delivery_info_repo.dart';

class DeliveryInfoRepoImpl implements DeliveryInfoRepo {
  final ApiService _apiService;

  DeliveryInfoRepoImpl(this._apiService);
  @override
  Future<DataState<List<DeliveryInfoEntity>>> getAllInfo() async {
    try {
      final httpResponse = await _apiService.getAllInfo();
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
