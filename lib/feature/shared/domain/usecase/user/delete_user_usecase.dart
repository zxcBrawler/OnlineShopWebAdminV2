import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/user_repository.dart';

class DeleteUserUsecase implements UseCase<DataState<void>, int> {
  final UserRepo _mainRepo;

  DeleteUserUsecase(this._mainRepo);

  @override
  Future<DataState<void>> call({int? params}) async {
    return await _mainRepo.deleteUser(id: params);
  }
}
