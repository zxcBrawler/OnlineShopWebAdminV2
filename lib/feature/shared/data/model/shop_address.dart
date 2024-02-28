import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';

class ShopAddressModel extends ShopAddressEntity {
  const ShopAddressModel({
    int? shopAddressId,
    String? shopAddressDirection,
    String? shopMetro,
    String? contactNumber,
    String? latitude,
    String? longitude,
  }) : super(
            shopAddressId: shopAddressId,
            shopAddressDirection: shopAddressDirection,
            shopMetro: shopMetro,
            contactNumber: contactNumber,
            latitude: latitude,
            longitude: longitude);

  factory ShopAddressModel.fromJson(Map<String, dynamic> map) {
    return ShopAddressModel(
        shopAddressId: map["shopAddressId"],
        shopAddressDirection: map["shopAddressDirection"],
        shopMetro: map["shopMetro"],
        contactNumber: map["contactNumber"],
        latitude: map["latitude"],
        longitude: map["longitude"]);
  }
}
