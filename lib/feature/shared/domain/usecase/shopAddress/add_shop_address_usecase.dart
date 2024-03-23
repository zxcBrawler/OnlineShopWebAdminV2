import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_address_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_address_repo.dart';

class AddShopAddressUsecase
    implements UseCase<DataState<ShopAddressEntity>, ShopAddressDTO> {
  final ShopAddressRepo _shopAddressRepo;

  AddShopAddressUsecase(this._shopAddressRepo);

  @override
  Future<DataState<ShopAddressEntity>> call({ShopAddressDTO? params}) async {
    return await _shopAddressRepo.addShopAddress(shopAddressDTO: params);
  }
}
