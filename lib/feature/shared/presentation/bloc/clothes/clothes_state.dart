import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_colors_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/photos_of_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/type_clothes_entity.dart';

abstract class RemoteClothesState {
  final List<ClothesEntity>? clothes;
  final List<ClothesColorsEntity>? clothesColors;
  final List<ClothesSizeClothesEntity>? clothesSizeClothes;
  final List<PhotosOfClothesEntity>? photosOfClothes;
  final List<TypeClothesEntity>? typeClothes;
  final ClothesEntity? addedClothes;
  final DioException? error;
  const RemoteClothesState(
      {this.clothes,
      this.clothesColors,
      this.clothesSizeClothes,
      this.photosOfClothes,
      this.addedClothes,
      this.typeClothes,
      this.error});
}

class RemoteClothesLoading extends RemoteClothesState {
  const RemoteClothesLoading();
}

class RemoteClothesDone extends RemoteClothesState {
  const RemoteClothesDone(List<ClothesEntity> clothes)
      : super(clothes: clothes);
}

class RemoteClothesAddDone extends RemoteClothesState {
  const RemoteClothesAddDone(ClothesEntity clothes)
      : super(addedClothes: clothes);
}

class RemoteClothesColorsDone extends RemoteClothesState {
  const RemoteClothesColorsDone(List<ClothesColorsEntity> clothesColors)
      : super(clothesColors: clothesColors);
}

class RemoteClothesSizeClothesDone extends RemoteClothesState {
  const RemoteClothesSizeClothesDone(
      List<ClothesSizeClothesEntity> clothesSizeClothes)
      : super(clothesSizeClothes: clothesSizeClothes);
}

class RemotePhotosOfClothesDone extends RemoteClothesState {
  const RemotePhotosOfClothesDone(List<PhotosOfClothesEntity> photosOfClothes)
      : super(photosOfClothes: photosOfClothes);
}

class RemoteTypeClothesDone extends RemoteClothesState {
  const RemoteTypeClothesDone(List<TypeClothesEntity> typeClothes)
      : super(typeClothes: typeClothes);
}

class RemoteClothesError extends RemoteClothesState {
  const RemoteClothesError(DioException error) : super(error: error);
}
