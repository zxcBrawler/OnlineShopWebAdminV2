import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';

class ClothesSizeClothesEntity {
  final int? id;
  final ClothesEntity? clothes;
  final SizeClothesEntity? sizeClothes;

  const ClothesSizeClothesEntity({this.id, this.clothes, this.sizeClothes});
}
