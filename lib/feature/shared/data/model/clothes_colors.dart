import 'package:xc_web_admin/feature/shared/data/model/clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/color.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_colors_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';

class ClothesColorsModel extends ClothesColorsEntity {
  const ClothesColorsModel({
    int? id,
    ClothesEntity? clothes,
    ColorEntity? colors,
  }) : super(id: id, clothes: clothes, colors: colors);

  factory ClothesColorsModel.fromJson(Map<String, dynamic> map) {
    return ClothesColorsModel(
        id: map["id"],
        clothes: ClothesModel.fromJson(map["clothes"]),
        colors: ColorModel.fromJson(map["colors"]));
  }
}
