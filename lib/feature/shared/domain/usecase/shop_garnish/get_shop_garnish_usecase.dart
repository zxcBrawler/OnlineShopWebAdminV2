import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_garnish_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_garnish_repo.dart';

class GetShopGarnishUsecase
    implements UseCase<DataState<List<ShopGarnishEntity>>, int> {
  final ShopGarnishRepo _shopGarnishRepo;

  GetShopGarnishUsecase(this._shopGarnishRepo);
  @override
  Future<DataState<List<ShopGarnishEntity>>> call({int? params}) async {
    return await _shopGarnishRepo.getShopGarnish(id: params);
  }
}
