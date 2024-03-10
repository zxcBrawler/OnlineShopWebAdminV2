import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/address/get_addresses_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/address/address_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/address/address_state.dart';
import 'package:bloc/bloc.dart';

class RemoteAddressesBloc
    extends Bloc<RemoteAddressesEvent, RemoteAddressState> {
  final GetAddressesUsecase _getAddressesUsecase;
  RemoteAddressesBloc(
    this._getAddressesUsecase,
  ) : super(const RemoteAddressLoading()) {
    on<GetAddresses>(onGetAddresses);
  }

  void onGetAddresses(
      GetAddresses event, Emitter<RemoteAddressState> emitter) async {
    final dataState = await _getAddressesUsecase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emitter(RemoteAddressDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emitter(RemoteAddressError(dataState.error!));
    }
  }
}
