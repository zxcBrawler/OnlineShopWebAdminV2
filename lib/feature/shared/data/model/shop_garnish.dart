import 'package:xc_web_admin/feature/shared/data/model/clothes_colors.dart';
import 'package:xc_web_admin/feature/shared/data/model/clothes_size_clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_colors_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_garnish_entity.dart';

class ShopGarnishModel extends ShopGarnishEntity {
  const ShopGarnishModel({
    int? shopGarnishId,
    ClothesSizeClothesEntity? sizeClothesGarnish,
    ClothesColorsEntity? colorClothesGarnish,
    ShopAddressEntity? shopAddressesGarnish,
    int? quantity,
  }) : super(
            shopGarnishId: shopGarnishId,
            sizeClothesGarnish: sizeClothesGarnish,
            colorClothesGarnish: colorClothesGarnish,
            shopAddressesGarnish: shopAddressesGarnish,
            quantity: quantity);

  factory ShopGarnishModel.fromJson(Map<String, dynamic> map) {
    return ShopGarnishModel(
        shopGarnishId: map["shopGarnishId"],
        sizeClothesGarnish:
            ClothesSizeClothesModel.fromJson(map["sizeClothesGarnish"]),
        colorClothesGarnish:
            ClothesColorsModel.fromJson(map["colorClothesGarnish"]),
        shopAddressesGarnish:
            ShopAddressModel.fromJson(map["shopAddressesGarnish"]),
        quantity: map["quantity"]);
  }
}
