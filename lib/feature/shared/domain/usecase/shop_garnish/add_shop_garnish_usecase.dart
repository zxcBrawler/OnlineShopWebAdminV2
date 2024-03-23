import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_garnish_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_garnish_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_garnish_repo.dart';

class AddShopGarnishUsecase
    implements UseCase<DataState<ShopGarnishEntity>, ShopGarnishDTO> {
  final ShopGarnishRepo _shopGarnishRepo;
  AddShopGarnishUsecase(this._shopGarnishRepo);
  @override
  Future<DataState<ShopGarnishEntity>> call({ShopGarnishDTO? params}) async {
    return await _shopGarnishRepo.addShopGarnish(shopGarnishDTO: params);
  }
}
