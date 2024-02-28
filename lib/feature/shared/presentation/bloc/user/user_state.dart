import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

abstract class RemoteUserState {
  final List<UserEntity>? users;
  final UserEntity? user;
  final DioException? error;

  const RemoteUserState({this.users, this.error, this.user});
}

class RemoteUserLoading extends RemoteUserState {
  const RemoteUserLoading();
}

class RemoteUserDone extends RemoteUserState {
  const RemoteUserDone(List<UserEntity> users) : super(users: users);
}

class RemoteAddUserDone extends RemoteUserState {
  const RemoteAddUserDone(UserEntity user) : super(user: user);
}

class RemoteUserError extends RemoteUserState {
  const RemoteUserError(DioException error) : super(error: error);
}
