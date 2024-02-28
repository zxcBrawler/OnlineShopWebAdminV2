import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';

abstract class RemoteDeliveryInfoState {
  final List<DeliveryInfoEntity>? info;
  final DioException? error;

  const RemoteDeliveryInfoState({this.info, this.error});
}

class RemoteDeliveryInfoLoading extends RemoteDeliveryInfoState {
  const RemoteDeliveryInfoLoading();
}

class RemoteDeliveryInfoDone extends RemoteDeliveryInfoState {
  const RemoteDeliveryInfoDone(List<DeliveryInfoEntity> info)
      : super(info: info);
}

class RemoteDeliveryInfoError extends RemoteDeliveryInfoState {
  const RemoteDeliveryInfoError(DioException error) : super(error: error);
}
