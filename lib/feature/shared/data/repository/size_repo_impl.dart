import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/size_repo.dart';

class SizeRepoImpl implements SizeRepo {
  final ApiService _apiService;

  SizeRepoImpl(this._apiService);

  @override
  Future<DataState<List<SizeClothesEntity>>> getSizes() async {
    try {
      final httpResponse = await _apiService.getAllSizes();
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
