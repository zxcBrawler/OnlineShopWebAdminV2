import 'package:xc_web_admin/feature/shared/data/model/type_clothes.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/type_clothes_entity.dart';

class ClothesModel extends ClothesEntity {
  const ClothesModel({
    int? idClothes,
    String? nameClothesEn,
    String? nameClothesRu,
    String? priceClothes,
    String? clothesPhoto,
    String? barcode,
    TypeClothesEntity? typeClothes,
  }) : super(
            idClothes: idClothes,
            nameClothesEn: nameClothesEn,
            nameClothesRu: nameClothesRu,
            priceClothes: priceClothes,
            clothesPhoto: clothesPhoto,
            barcode: barcode,
            typeClothes: typeClothes);
  factory ClothesModel.fromJson(Map<String, dynamic> map) {
    return ClothesModel(
        idClothes: map["idClothes"],
        nameClothesEn: map["nameClothesEn"],
        nameClothesRu: map["nameClothesRu"],
        priceClothes: map["priceClothes"],
        clothesPhoto: map["clothesPhoto"],
        barcode: map["barcode"],
        typeClothes: TypeClothesModel.fromJson(map["typeClothes"]));
  }
}
