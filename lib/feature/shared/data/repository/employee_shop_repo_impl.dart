import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/employee_shop.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/employee_shop_repo.dart';

class EmployeeShopRepoImpl implements EmployeeShopRepo {
  final ApiService _apiService;

  EmployeeShopRepoImpl(this._apiService);

  @override
  Future<DataState<List<EmployeeShopEntity>>> getAllEmployeesFromShop(
      {int? id}) async {
    try {
      final httpResponse = await _apiService.getAllEmployees(shopAddressId: id);
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
  Future<DataState<EmployeeShopEntity>> getShopAddressByEmployeeId(
      {int? id}) async {
    try {
      final httpResponse =
          await _apiService.getShopAddressByEmployeeId(employeeId: id);
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
