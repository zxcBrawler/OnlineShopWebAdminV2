import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/model/role.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/role_repository.dart';

class RoleRepoImpl implements RoleRepo {
  final ApiService _apiService;

  RoleRepoImpl(this._apiService);

  @override
  Future<DataState<List<RoleModel>>> getRoles() async {
    try {
      final httpResponse = await _apiService.getRoles();
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
