import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/role_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/role_repository.dart';

class GetRolesUsecase implements UseCase<DataState<List<RoleEntity>>, void> {
  final RoleRepo _mainRepo;

  GetRolesUsecase(this._mainRepo);

  @override
  Future<DataState<List<RoleEntity>>> call({void params}) async {
    return await _mainRepo.getRoles();
  }
}
