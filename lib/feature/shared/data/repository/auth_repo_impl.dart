import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_dto.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_responce.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService _apiService;

  AuthRepoImpl(this._apiService);

  @override
  Future<DataState<LoginResponse>> authorize({LoginDTO? loginDTO}) async {
    try {
      final httpResponse = await _apiService.login(
          username: loginDTO!.username!, passwordHash: loginDTO.passwordHash!);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            message: httpResponse.data.message,
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
  Future<DataState<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
