import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/data/dto/edit_status_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/status_repo.dart';

class UpdateStatusUsecase implements UseCase<DataState<void>, StatusDTO> {
  final StatusRepo _mainRepo;

  UpdateStatusUsecase(this._mainRepo);

  @override
  Future<DataState<void>> call({StatusDTO? params}) async {
    return await _mainRepo.updateStatus(statusDTO: params);
  }
}
