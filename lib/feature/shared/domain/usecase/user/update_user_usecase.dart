import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_edit_user_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/user_repository.dart';

class UpdateUserUsecase implements UseCase<DataState<UserEntity>, UserDTO> {
  final UserRepo _mainRepo;

  UpdateUserUsecase(this._mainRepo);

  @override
  Future<DataState<UserEntity>> call({UserDTO? params}) async {
    return await _mainRepo.updateUser(user: params!);
  }
}
