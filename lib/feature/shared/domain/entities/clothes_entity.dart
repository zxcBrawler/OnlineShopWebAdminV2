import 'package:xc_web_admin/feature/shared/domain/entities/type_clothes_entity.dart';

class ClothesEntity {
  final int? idClothes;
  final String? nameClothesEn;
  final String? nameClothesRu;
  final String? priceClothes;
  final String? clothesPhoto;
  final String? barcode;
  final TypeClothesEntity? typeClothes;

  const ClothesEntity({
    this.idClothes,
    this.nameClothesEn,
    this.nameClothesRu,
    this.priceClothes,
    this.clothesPhoto,
    this.barcode,
    this.typeClothes,
  });

  List<String> getProperties() {
    return [
      'name clothes en',
      'name clothes ru',
      'price clothes',
      'barcode',
      'type clothes',
      'clothes gender',
    ];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'name clothes en':
        return nameClothesEn;
      case 'name clothes ru':
        return nameClothesRu;
      case 'price clothes':
        return priceClothes;
      case 'barcode':
        return barcode;
      case 'type clothes':
        return typeClothes!.nameType;
      case 'clothes gender':
        return typeClothes!.categoryClothes!.nameCategory;
      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
