import 'package:xc_web_admin/feature/shared/data/model/category_clothes.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/category_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/type_clothes_entity.dart';

class TypeClothesModel extends TypeClothesEntity {
  const TypeClothesModel({
    int? idType,
    String? nameType,
    CategoryClothesEntity? categoryClothes,
  }) : super(
            idType: idType,
            nameType: nameType,
            categoryClothes: categoryClothes);

  factory TypeClothesModel.fromJson(Map<String, dynamic> map) {
    return TypeClothesModel(
        idType: map["idType"],
        nameType: map["nameType"],
        categoryClothes: CategoryClothesModel.fromJson(map["categoryClothes"]));
  }

  factory TypeClothesModel.fromEntity(TypeClothesEntity typeClothesEntity) {
    return TypeClothesModel(
        idType: typeClothesEntity.idType,
        nameType: typeClothesEntity.nameType,
        categoryClothes: typeClothesEntity.categoryClothes);
  }
}
