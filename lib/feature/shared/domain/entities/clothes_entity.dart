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
}
