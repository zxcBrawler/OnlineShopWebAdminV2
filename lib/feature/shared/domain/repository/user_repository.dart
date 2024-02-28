import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_edit_user_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

abstract class UserRepo {
  Future<DataState<List<UserEntity>>> getAllUsers();
  Future<DataState<UserEntity>> addUser({UserDTO? user});
}
