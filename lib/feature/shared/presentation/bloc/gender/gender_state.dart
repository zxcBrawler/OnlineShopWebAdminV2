import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/category_clothes_entity.dart';

abstract class RemoteGenderState {
  final List<CategoryClothesEntity>? genders;
  final DioException? error;

  const RemoteGenderState({this.genders, this.error});
}

class RemoteGenderLoading extends RemoteGenderState {
  const RemoteGenderLoading();
}

class RemoteGenderDone extends RemoteGenderState {
  const RemoteGenderDone(List<CategoryClothesEntity> genders)
      : super(genders: genders);
}

class RemoteGenderError extends RemoteGenderState {
  const RemoteGenderError(DioException error) : super(error: error);
}
