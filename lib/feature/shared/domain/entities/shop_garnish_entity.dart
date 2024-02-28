import 'package:xc_web_admin/feature/shared/domain/entities/clothes_colors_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';

class ShopGarnishEntity {
  final int? shopGarnishId;
  final ClothesSizeClothesEntity? sizeClothesGarnish;
  final ClothesColorsEntity? colorClothesGarnish;
  final ShopAddressEntity? shopAddressesGarnish;
  final int? quantity;

  const ShopGarnishEntity(
      {this.shopGarnishId,
      this.sizeClothesGarnish,
      this.colorClothesGarnish,
      this.shopAddressesGarnish,
      this.quantity});
}
