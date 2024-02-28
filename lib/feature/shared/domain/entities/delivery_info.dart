import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/type_delivery_entity.dart';

class DeliveryInfoEntity {
  final int? id;
  final OrderEntity? order;
  final TypeDeliveryEntity? typeDelivery;
  final ShopAddressEntity? shopAddresses;
  final AddressEntity? addresses;

  const DeliveryInfoEntity(
      {this.id,
      this.order,
      this.typeDelivery,
      this.shopAddresses,
      this.addresses});

  List<String> getProperties() {
    return [
      'order number',
      'order date',
      'order time',
      'order sum',
      'current status',
      'user',
      'user address',
      'shop address',
    ];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'order number':
        return order!.numberOrder;
      case 'order date':
        return order!.dateOrder;
      case 'order time':
        return order!.timeOrder;
      case 'order sum':
        return order!.sumOrder;
      case 'current status':
        return order!.currentStatus!.nameStatus;
      case 'user':
        return order!.userCard!.user!.email;
      case 'user address':
        return addresses!.directionAddress;
      case 'shop address':
        return shopAddresses!.shopAddressDirection;

      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
