import 'package:xc_web_admin/feature/shared/domain/entities/clothes_photo_entity.dart';

class ClothesPhotoModel extends ClothesPhotoEntity {
  const ClothesPhotoModel({
    int? id,
    String? photoAddress,
  }) : super(id: id, photoAddress: photoAddress);

  factory ClothesPhotoModel.fromJson(Map<String, dynamic> map) {
    return ClothesPhotoModel(id: map["id"], photoAddress: map["photoAddress"]);
  }
}
