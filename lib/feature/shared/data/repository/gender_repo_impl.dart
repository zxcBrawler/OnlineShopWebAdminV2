import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/model/category_clothes.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/gender_repository.dart';

class GenderRepoImpl implements GenderRepo {
  final ApiService _apiService;

  GenderRepoImpl(this._apiService);
  @override
  Future<DataState<List<CategoryClothesModel>>> getGenders() async {
    try {
      final httpResponse =
          await _apiService.getGenders(accessToken: accessToken!);
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
