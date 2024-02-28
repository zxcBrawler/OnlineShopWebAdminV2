import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';

class ColorModel extends ColorEntity {
  const ColorModel({
    int? colorId,
    String? nameColor,
    String? hex,
  }) : super(colorId: colorId, nameColor: nameColor, hex: hex);

  factory ColorModel.fromJson(Map<String, dynamic> map) {
    return ColorModel(
        colorId: map["colorId"], nameColor: map["nameColor"], hex: map["hex"]);
  }
}
