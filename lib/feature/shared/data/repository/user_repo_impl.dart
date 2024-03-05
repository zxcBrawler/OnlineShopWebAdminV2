import 'dart:io';

import 'package:dio/dio.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_edit_user_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/user_repository.dart';

class UserRepoImpl implements UserRepo {
  final ApiService _apiService;

  UserRepoImpl(this._apiService);

  @override
  Future<DataState<List<UserEntity>>> getAllUsers() async {
    try {
      final httpResponse =
          await _apiService.getUsers(accessToken: accessToken!);
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
  Future<DataState<UserEntity>> addUser({UserDTO? user}) async {
    try {
      final httpResponse = await _apiService.addUser(
          gender: user!.gender,
          role: user.role,
          employeeNumber: user.employeeNumber,
          passwordHash: user.passwordHash,
          phoneNumber: user.phoneNumber,
          username: user.username,
          email: user.email,
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

  @override
  Future<DataState<UserEntity>> updateUser({UserDTO? user}) async {
    try {
      final httpResponse = await _apiService.updateUserById(
          id: user!.id,
          gender: user.gender,
          role: user.role,
          employeeNumber: user.employeeNumber,
          passwordHash: user.passwordHash,
          phoneNumber: user.phoneNumber,
          username: user.username,
          email: user.email,
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

  @override
  Future<DataState<void>> deleteUser({int? id}) async {
    try {
      final httpResponse =
          await _apiService.deleteUserById(id: id!, accessToken: accessToken!);
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
