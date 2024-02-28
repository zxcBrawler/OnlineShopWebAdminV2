import 'package:xc_web_admin/feature/shared/domain/entities/category_clothes_entity.dart';

class TypeClothesEntity {
  final int? idType;
  final String? nameType;
  final CategoryClothesEntity? categoryClothes;

  const TypeClothesEntity({this.idType, this.nameType, this.categoryClothes});
}
