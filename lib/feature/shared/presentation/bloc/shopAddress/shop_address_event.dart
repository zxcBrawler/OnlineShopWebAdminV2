import 'package:xc_web_admin/feature/shared/data/dto/shop_address_dto.dart';

abstract class RemoteShopAddressesEvent {
  final dynamic param;
  const RemoteShopAddressesEvent({this.param});

  List<Object> get props => [param!];
}

class GetShopAddresses extends RemoteShopAddressesEvent {
  const GetShopAddresses();
}

class AddShopAddress extends RemoteShopAddressesEvent {
  final ShopAddressDTO? shopAddressDTO;
  const AddShopAddress(this.shopAddressDTO);
}

class UpdateShopAddress extends RemoteShopAddressesEvent {
  final ShopAddressDTO? shopAddressDTO;
  const UpdateShopAddress(this.shopAddressDTO);
}

class DeleteShopAddress extends RemoteShopAddressesEvent {
  final int? id;
  const DeleteShopAddress(this.id);
}
