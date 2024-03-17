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

  List<String> getProperties() {
    return [
      'barcode',
      'clothes name ru',
      'clothes name en',
      'price clothes',
      'size',
      'color',
      'quantity'
    ];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'barcode':
        return sizeClothesGarnish!.clothes!.barcode;

      case 'clothes name ru':
        return sizeClothesGarnish!.clothes!.nameClothesRu;

      case 'clothes name en':
        return sizeClothesGarnish!.clothes!.nameClothesEn;

      case 'price clothes':
        return sizeClothesGarnish!.clothes!.priceClothes;

      case 'size':
        return sizeClothesGarnish!.sizeClothes!.nameSize;

      case 'color':
        return colorClothesGarnish!.colors!.nameColor;

      case 'quantity':
        return quantity;
      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
