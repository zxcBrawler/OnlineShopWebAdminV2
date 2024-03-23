import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_address_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';

abstract class ShopAddressRepo {
  Future<DataState<List<ShopAddressEntity>>> getAllShopAddresses();
  Future<DataState<void>> deleteAddress(int? id);
  Future<DataState<ShopAddressEntity>> addShopAddress(
      {ShopAddressDTO? shopAddressDTO});

  Future<DataState<ShopAddressEntity>> updateShopAddress(
      {ShopAddressDTO? shopAddressDTO});
}
