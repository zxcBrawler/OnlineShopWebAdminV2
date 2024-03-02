import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_responce.dart';

abstract class AuthState {
  final LoginResponse? loginResponse;
  final DioException? error;

  const AuthState({this.loginResponse, this.error});
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateDone extends AuthState {
  const AuthStateDone(LoginResponse loginResponse)
      : super(loginResponse: loginResponse);
}

class AuthStateError extends AuthState {
  const AuthStateError(DioException error) : super(error: error);
}
