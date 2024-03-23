import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';

abstract class RemoteShopAddressState {
  final ShopAddressEntity? shopAddress;
  final List<ShopAddressEntity>? shopAddresses;
  final DioException? error;

  const RemoteShopAddressState(
      {this.shopAddresses, this.error, this.shopAddress});
}

class RemoteShopAddressLoading extends RemoteShopAddressState {
  const RemoteShopAddressLoading();
}

class RemoteShopAddressDone extends RemoteShopAddressState {
  const RemoteShopAddressDone(List<ShopAddressEntity> shopAddresses)
      : super(shopAddresses: shopAddresses);
}

class RemoteAddShopAddressDone extends RemoteShopAddressState {
  const RemoteAddShopAddressDone(ShopAddressEntity shopAddress)
      : super(shopAddress: shopAddress);
}

class RemoteShopAddressError extends RemoteShopAddressState {
  const RemoteShopAddressError(DioException error) : super(error: error);
}
