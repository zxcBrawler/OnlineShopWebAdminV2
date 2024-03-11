import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';

abstract class RemoteSizeState {
  final List<SizeClothesEntity>? sizes;
  final DioException? error;
  const RemoteSizeState({this.sizes, this.error});
}

class RemoteSizesLoading extends RemoteSizeState {
  const RemoteSizesLoading();
}

class RemoteSizesDone extends RemoteSizeState {
  const RemoteSizesDone(List<SizeClothesEntity> sizes) : super(sizes: sizes);
}

class RemoteSizesError extends RemoteSizeState {
  const RemoteSizesError(DioException error) : super(error: error);
}
