import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_dto.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_responce.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/auth_repo.dart';

class Authenticate implements UseCase<DataState<LoginResponse>, LoginDTO> {
  final AuthRepo _authRepo;

  Authenticate(this._authRepo);

  @override
  Future<DataState<LoginResponse>> call({LoginDTO? params}) async {
    return _authRepo.authorize(loginDTO: params);
  }
}
