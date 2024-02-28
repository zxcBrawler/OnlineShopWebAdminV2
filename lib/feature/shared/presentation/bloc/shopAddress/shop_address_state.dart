import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';

abstract class RemoteShopAddressState {
  final List<ShopAddressEntity>? shopAddresses;
  final DioException? error;

  const RemoteShopAddressState({this.shopAddresses, this.error});
}

class RemoteShopAddressLoading extends RemoteShopAddressState {
  const RemoteShopAddressLoading();
}

class RemoteShopAddressDone extends RemoteShopAddressState {
  const RemoteShopAddressDone(List<ShopAddressEntity> shopAddresses)
      : super(shopAddresses: shopAddresses);
}

class RemoteShopAddressError extends RemoteShopAddressState {
  const RemoteShopAddressError(DioException error) : super(error: error);
}
