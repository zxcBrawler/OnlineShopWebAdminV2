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

  /// Handles the [GetAddresses] event by calling the
  /// [_getAddressesUsecase] and emitting the appropriate state.
  ///
  /// If the [_getAddressesUsecase] returns a [DataSuccess] with
  /// non-empty data, it emits a [RemoteAddressDone] state with
  /// the retrieved data. If the [_getAddressesUsecase]
  /// returns a [DataSuccess] with empty data, it emits a
  /// [RemoteAddressDone] state with an empty list. If the
  /// [_getAddressesUsecase] returns a [DataFailed],
  /// it emits a [RemoteAddressError] state with the error message.
  void onGetAddresses(
      GetAddresses event, Emitter<RemoteAddressState> emitter) async {
    // Call the use case to get addresses.
    final dataState = await _getAddressesUsecase(params: event.id);

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteAddressDone state with the retrieved data.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteAddressDone state with the retrieved data.
      emitter(RemoteAddressDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data,
    // emit a RemoteAddressDone state with an empty list.
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      // Emit the RemoteAddressDone state with an empty list.
      emitter(const RemoteAddressDone([]));
    }

    // If the use case returns a DataFailed,
    // emit a RemoteAddressError state with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteAddressError state with the error message.
      emitter(RemoteAddressError(dataState.error!));
    }
  }
}
