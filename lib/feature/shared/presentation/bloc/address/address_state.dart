import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';

abstract class RemoteAddressState {
  final List<AddressEntity>? addresses;
  final DioException? error;

  const RemoteAddressState({this.addresses, this.error});
}

class RemoteAddressLoading extends RemoteAddressState {
  const RemoteAddressLoading();
}

class RemoteAddressDone extends RemoteAddressState {
  const RemoteAddressDone(List<AddressEntity> addresses)
      : super(addresses: addresses);
}

class RemoteAddressError extends RemoteAddressState {
  const RemoteAddressError(DioException error) : super(error: error);
}
