import 'package:xc_web_admin/feature/shared/data/model/clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/clothes_photo.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_photo_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/photos_of_clothes_entity.dart';

class PhotosOfClothesModel extends PhotosOfClothesEntity {
  const PhotosOfClothesModel({
    int? id,
    ClothesEntity? clothesId,
    ClothesPhotoEntity? clothesPhoto,
  }) : super(id: id, clothesId: clothesId, clothesPhoto: clothesPhoto);

  factory PhotosOfClothesModel.fromJson(Map<String, dynamic> map) {
    return PhotosOfClothesModel(
        id: map["id"],
        clothesId: ClothesModel.fromJson(map["clothesId"]),
        clothesPhoto: ClothesPhotoModel.fromJson(map["clothesPhoto"]));
  }
}
