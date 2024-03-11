import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';

abstract class RemoteColorState {
  final List<ColorEntity>? colors;
  final DioException? error;
  const RemoteColorState({this.colors, this.error});
}

class RemoteColorsLoading extends RemoteColorState {
  const RemoteColorsLoading();
}

class RemoteColorsDone extends RemoteColorState {
  const RemoteColorsDone(List<ColorEntity> colors) : super(colors: colors);
}

class RemoteColorsError extends RemoteColorState {
  const RemoteColorsError(DioException error) : super(error: error);
}
