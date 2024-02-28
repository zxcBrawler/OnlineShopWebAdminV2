import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_photo_entity.dart';

class PhotosOfClothesEntity {
  final int? id;
  final ClothesEntity? clothesId;
  final ClothesPhotoEntity? clothesPhoto;

  const PhotosOfClothesEntity({this.id, this.clothesId, this.clothesPhoto});
}
