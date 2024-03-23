import 'package:xc_web_admin/feature/shared/data/dto/shop_garnish_dto.dart';

abstract class RemoteShopGarnishEvent {
  final dynamic params;

  const RemoteShopGarnishEvent({this.params});
}

class GetShopGarnish extends RemoteShopGarnishEvent {
  final int id;
  const GetShopGarnish({required this.id});
}

class UpdateQuantity extends RemoteShopGarnishEvent {
  final ShopGarnishDTO shopGarnishDTO;
  const UpdateQuantity({required this.shopGarnishDTO});
}

class AddShopGarnish extends RemoteShopGarnishEvent {
  final ShopGarnishDTO shopGarnishDTO;
  const AddShopGarnish({required this.shopGarnishDTO});
}

class DeleteShopGarnish extends RemoteShopGarnishEvent {
  final int id;
  const DeleteShopGarnish({required this.id});
}
