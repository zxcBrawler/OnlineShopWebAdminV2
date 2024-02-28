import 'package:xc_web_admin/feature/shared/domain/entities/category_clothes_entity.dart';

class CategoryClothesModel extends CategoryClothesEntity {
  const CategoryClothesModel({
    int? id,
    String? nameCategory,
  }) : super(id: id, nameCategory: nameCategory);

  factory CategoryClothesModel.fromJson(Map<String, dynamic> map) {
    return CategoryClothesModel(
        id: map["id"], nameCategory: map["nameCategory"]);
  }

  factory CategoryClothesModel.fromEntity(
      CategoryClothesEntity categoryClothesEntity) {
    return CategoryClothesModel(
        id: categoryClothesEntity.id,
        nameCategory: categoryClothesEntity.nameCategory);
  }
}
