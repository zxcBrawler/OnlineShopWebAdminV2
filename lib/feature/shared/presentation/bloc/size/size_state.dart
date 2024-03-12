import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';

abstract class RemoteSizeState {
  final List<SizeClothesEntity>? sizes;
  final SizeClothesEntity? size;
  final DioException? error;

  const RemoteSizeState({this.sizes, this.error, this.size});
}

class RemoteSizesLoading extends RemoteSizeState {
  const RemoteSizesLoading();
}

class RemoteSizesDone extends RemoteSizeState {
  const RemoteSizesDone(List<SizeClothesEntity> sizes) : super(sizes: sizes);
}

class RemoteAddSizeDone extends RemoteSizeState {
  const RemoteAddSizeDone(SizeClothesEntity size) : super(size: size);
}

class RemoteSizesError extends RemoteSizeState {
  const RemoteSizesError(DioException error) : super(error: error);
}
