import 'package:xc_web_admin/feature/shared/data/model/address.dart';
import 'package:xc_web_admin/feature/shared/data/model/order.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';
import 'package:xc_web_admin/feature/shared/data/model/type_delivery.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/type_delivery_entity.dart';

class DeliveryInfoModel extends DeliveryInfoEntity {
  const DeliveryInfoModel({
    int? id,
    OrderEntity? order,
    TypeDeliveryEntity? typeDelivery,
    ShopAddressEntity? shopAddresses,
    AddressEntity? addresses,
  }) : super(
            id: id,
            order: order,
            typeDelivery: typeDelivery,
            shopAddresses: shopAddresses,
            addresses: addresses);

  factory DeliveryInfoModel.fromJson(Map<String, dynamic> map) {
    return DeliveryInfoModel(
        id: map["id"],
        order: OrderModel.fromJson(map["order"]),
        typeDelivery: TypeDeliveryModel.fromJson(map["typeDelivery"]),
        shopAddresses: ShopAddressModel.fromJson(map["shopAddresses"] ?? {}),
        addresses: AddressModel.fromJson(map["addresses"] ?? {}));
  }
}
