import 'package:xc_web_admin/feature/shared/data/dto/add_edit_user_dto.dart';

abstract class RemoteUserEvent {
  final dynamic param;
  const RemoteUserEvent({this.param});
}

class GetUsers extends RemoteUserEvent {
  const GetUsers();
}

class AddUser extends RemoteUserEvent {
  final UserDTO user;
  const AddUser({required this.user});
}

class UpdateUser extends RemoteUserEvent {
  final UserDTO user;
  const UpdateUser({required this.user});
}

class DeleteUser extends RemoteUserEvent {
  final int id;
  const DeleteUser({required this.id});
}
