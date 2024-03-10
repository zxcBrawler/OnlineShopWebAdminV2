import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_clothes_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_colors_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/photos_of_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/type_clothes_entity.dart';

abstract class ClothesRepo {
  Future<DataState<List<ClothesEntity>>> getClothes();
  Future<DataState<List<ClothesColorsEntity>>> getClothesColors({int? id});
  Future<DataState<List<PhotosOfClothesEntity>>> getPhotosOfClothes({int? id});
  Future<DataState<List<ClothesSizeClothesEntity>>> getClothesSizeClothes(
      {int? id});

  Future<DataState<List<TypeClothesEntity>>> getTypeClothes({int? id});
  Future<DataState<ClothesEntity>> addClothes({
    ClothesDTO? clothesDTO,
  });
}
