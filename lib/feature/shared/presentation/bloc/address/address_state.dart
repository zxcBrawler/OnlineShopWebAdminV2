import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_address_entity.dart';

abstract class RemoteAddressState {
  final List<UserAddressEntity>? addresses;
  final DioException? error;

  const RemoteAddressState({this.addresses, this.error});
}

class RemoteAddressLoading extends RemoteAddressState {
  const RemoteAddressLoading();
}

class RemoteAddressDone extends RemoteAddressState {
  const RemoteAddressDone(List<UserAddressEntity> addresses)
      : super(addresses: addresses);
}

class RemoteAddressError extends RemoteAddressState {
  const RemoteAddressError(DioException error) : super(error: error);
}
