import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';

class ClothesColorsEntity {
  final int? id;
  final ClothesEntity? clothes;
  final ColorEntity? colors;

  const ClothesColorsEntity({this.id, this.clothes, this.colors});
}
