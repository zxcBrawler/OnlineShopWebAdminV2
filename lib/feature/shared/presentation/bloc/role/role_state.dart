import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/role_entity.dart';

abstract class RemoteRoleState {
  final List<RoleEntity>? roles;
  final DioException? error;

  const RemoteRoleState({this.roles, this.error});
}

class RemoteRoleLoading extends RemoteRoleState {
  const RemoteRoleLoading();
}

class RemoteRoleDone extends RemoteRoleState {
  const RemoteRoleDone(List<RoleEntity> roles) : super(roles: roles);
}

class RemoteRoleError extends RemoteRoleState {
  const RemoteRoleError(DioException error) : super(error: error);
}
