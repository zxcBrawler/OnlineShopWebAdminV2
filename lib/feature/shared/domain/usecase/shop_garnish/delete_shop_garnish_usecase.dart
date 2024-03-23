import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_garnish_repo.dart';

class DeleteShopGarnishUsecase implements UseCase<DataState<void>, int> {
  final ShopGarnishRepo _shopGarnishRepo;

  DeleteShopGarnishUsecase(this._shopGarnishRepo);

  @override
  Future<DataState<void>> call({int? params}) async {
    return await _shopGarnishRepo.deleteShopGarnish(id: params);
  }
}
