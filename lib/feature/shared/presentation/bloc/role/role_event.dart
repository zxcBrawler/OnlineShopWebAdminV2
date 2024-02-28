abstract class RemoteRoleEvent {
  final dynamic param;
  const RemoteRoleEvent({this.param});
}

class GetRoles extends RemoteRoleEvent {
  const GetRoles();
}
