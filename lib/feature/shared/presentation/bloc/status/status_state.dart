import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/status_order_entity.dart';

abstract class RemoteStatusState {
  final List<StatusOrderEntity>? statuses;
  final DioException? error;

  const RemoteStatusState({this.statuses, this.error});
}

class RemoteStatusLoading extends RemoteStatusState {
  const RemoteStatusLoading();
}

class RemoteStatusDone extends RemoteStatusState {
  const RemoteStatusDone(List<StatusOrderEntity> statuses)
      : super(statuses: statuses);
}

class RemoteStatusError extends RemoteStatusState {
  const RemoteStatusError(DioException error) : super(error: error);
}
