import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_address_repo.dart';

class GetShopAddressesUsecase
    implements UseCase<DataState<List<ShopAddressEntity>>, void> {
  final ShopAddressRepo _mainRepo;

  GetShopAddressesUsecase(this._mainRepo);
  @override
  Future<DataState<List<ShopAddressEntity>>> call({void params}) async {
    return await _mainRepo.getAllShopAddresses();
  }
}
