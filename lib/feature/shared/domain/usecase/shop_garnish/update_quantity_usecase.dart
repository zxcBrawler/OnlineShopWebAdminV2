import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_garnish_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_garnish_repo.dart';

class UpdateQuantityUsecase
    implements UseCase<DataState<void>, ShopGarnishDTO> {
  final ShopGarnishRepo _mainRepo;

  UpdateQuantityUsecase(this._mainRepo);

  @override
  Future<DataState<void>> call({ShopGarnishDTO? params}) async {
    return await _mainRepo.updateQuantity(shopGarnishDTO: params);
  }
}
