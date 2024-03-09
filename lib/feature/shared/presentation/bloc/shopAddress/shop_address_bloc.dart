import 'package:bloc/bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shopAddress/delete_shop_address_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shopAddress/get_shop_addresses_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_state.dart';

class RemoteShopAddressesBloc
    extends Bloc<RemoteShopAddressesEvent, RemoteShopAddressState> {
  final GetShopAddressesUsecase _getShopAddressesUsecase;
  final DeleteShopAddressUsecase _deleteShopAddressUsecase;
  RemoteShopAddressesBloc(
    this._getShopAddressesUsecase,
    this._deleteShopAddressUsecase,
  ) : super(const RemoteShopAddressLoading()) {
    on<GetShopAddresses>(onGetShopAddresses);
    on<DeleteShopAddress>(onDeleteShopAddresses);
  }

  /// Handles the [GetShopAddresses] event by calling the
  /// [_getShopAddressesUsecase] and emitting the appropriate state.
  ///
  /// If the [_getShopAddressesUsecase] returns a [DataSuccess] with
  /// non-empty data, it emits a [RemoteShopAddressDone] state with
  /// the retrieved data. If the [_getShopAddressesUsecase]
  /// returns a [DataSuccess] with empty data, it emits a
  /// [RemoteShopAddressError] state with the error message.
  /// If the [_getShopAddressesUsecase] returns a [DataFailed],
  /// it emits a [RemoteShopAddressError] state with the error message.
  void onGetShopAddresses(
      GetShopAddresses event, Emitter<RemoteShopAddressState> emitter) async {
    // Call the use case to get shop addresses.
    final dataState = await _getShopAddressesUsecase();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteShopAddressDone state with the retrieved data.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteShopAddressDone state with the retrieved data.
      emitter(RemoteShopAddressDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data,
    // emit a RemoteShopAddressError state with the error message.
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      // Emit the RemoteShopAddressError state with the error message.
      emitter(RemoteShopAddressError(dataState.error!));
    }

    // If the use case returns a DataFailed,
    // emit a RemoteShopAddressError state with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteShopAddressError state with the error message.
      emitter(RemoteShopAddressError(dataState.error!));
    }
  }

  /// Handles the [DeleteShopAddress] event by calling the
  /// [_deleteShopAddressUsecase] and emits the appropriate state.
  ///
  /// If the [_deleteShopAddressUsecase] returns a [DataSuccess] with
  /// non-empty data, it prints the data and emits a
  /// [RemoteShopAddressDone] state with the retrieved data.
  /// If the [_deleteShopAddressUsecase] returns a [DataFailed],
  /// it prints the error and emits a [RemoteShopAddressError] state
  /// with the error message.
  ///
  /// The [event] parameter is the DeleteShopAddress event.
  /// The [emitter] parameter is a function used to emit states.
  void onDeleteShopAddresses(
      DeleteShopAddress event, Emitter<RemoteShopAddressState> emitter) async {
    // Call the use case to delete a shop address.
    final dataState = await _deleteShopAddressUsecase(params: event.id);

    // If the use case returns a DataSuccess with non-empty data,
    // print the data and emit a RemoteShopAddressDone state with the retrieved data.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteShopAddressDone state with the retrieved data.
      emitter(RemoteShopAddressDone(dataState.data!));
    }

    // If the use case returns a DataFailed,
    // print the error and emit a RemoteShopAddressError state with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteShopAddressError state with the error message.
      emitter(RemoteShopAddressError(dataState.error!));
    }
  }
}
