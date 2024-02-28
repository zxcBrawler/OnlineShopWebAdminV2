import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/user_repository.dart';

class GetUsersUsecase implements UseCase<DataState<List<UserEntity>>, void> {
  final UserRepo _mainRepo;

  GetUsersUsecase(this._mainRepo);

  @override
  Future<DataState<List<UserEntity>>> call({void params}) async {
    return await _mainRepo.getAllUsers();
  }
}
