import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';

abstract class RemoteOrderCompState {
  final List<OrderCompositionEntity>? compositions;
  final DioException? error;

  const RemoteOrderCompState({this.compositions, this.error});
}

class RemoteOrderCompLoading extends RemoteOrderCompState {
  const RemoteOrderCompLoading();
}

class RemoteOrderCompDone extends RemoteOrderCompState {
  const RemoteOrderCompDone(List<OrderCompositionEntity> compositions)
      : super(compositions: compositions);
}

class RemoteOrderCompError extends RemoteOrderCompState {
  const RemoteOrderCompError(DioException error) : super(error: error);
}
