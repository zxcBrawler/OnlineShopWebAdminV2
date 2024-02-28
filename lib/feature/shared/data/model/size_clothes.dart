import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';

class SizeClothesModel extends SizeClothesEntity {
  const SizeClothesModel({int? id, String? nameSize})
      : super(id: id, nameSize: nameSize);

  factory SizeClothesModel.fromJson(Map<String, dynamic> map) {
    return SizeClothesModel(id: map["id"], nameSize: map["nameSize"]);
  }
}
