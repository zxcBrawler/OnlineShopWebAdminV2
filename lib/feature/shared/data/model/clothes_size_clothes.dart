import 'package:xc_web_admin/feature/shared/data/model/clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/size_clothes.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';

class ClothesSizeClothesModel extends ClothesSizeClothesEntity {
  const ClothesSizeClothesModel({
    int? id,
    ClothesEntity? clothes,
    SizeClothesEntity? sizeClothes,
  }) : super(id: id, clothes: clothes, sizeClothes: sizeClothes);

  factory ClothesSizeClothesModel.fromJson(Map<String, dynamic> map) {
    return ClothesSizeClothesModel(
        id: map["id"],
        clothes: ClothesModel.fromJson(map["clothes"]),
        sizeClothes: SizeClothesModel.fromJson(map["sizeClothes"]));
  }
}
