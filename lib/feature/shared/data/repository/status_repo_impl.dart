import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/edit_status_dto.dart';
import 'package:xc_web_admin/feature/shared/data/model/status_order.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/status_repo.dart';

class StatusRepoImpl implements StatusRepo {
  final ApiService _apiService;

  StatusRepoImpl(this._apiService);

  @override
  Future<DataState<List<StatusOrderModel>>> getStatuses() async {
    try {
      final httpResponse =
          await _apiService.getStatuses(accessToken: accessToken!);
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
  Future<DataState<void>> updateStatus({StatusDTO? statusDTO}) async {
    try {
      final httpResponse = await _apiService.updateStatus(
          id: statusDTO!.id,
          statusID: statusDTO.statusID,
          accessToken: accessToken!);

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
