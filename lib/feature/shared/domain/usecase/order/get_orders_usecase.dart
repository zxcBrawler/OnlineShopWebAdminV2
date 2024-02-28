import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/delivery_info_repo.dart';

class GetDeliveryInfoUsecase
    implements UseCase<DataState<List<DeliveryInfoEntity>>, void> {
  final DeliveryInfoRepo _mainRepo;

  GetDeliveryInfoUsecase(this._mainRepo);

  @override
  Future<DataState<List<DeliveryInfoEntity>>> call({void params}) async {
    return await _mainRepo.getAllInfo();
  }
}
