import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/status_order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/status_repo.dart';

class GetStatusesUsecase
    implements UseCase<DataState<List<StatusOrderEntity>>, void> {
  final StatusRepo _mainRepo;

  GetStatusesUsecase(this._mainRepo);

  @override
  Future<DataState<List<StatusOrderEntity>>> call({void params}) async {
    return await _mainRepo.getStatuses();
  }
}
