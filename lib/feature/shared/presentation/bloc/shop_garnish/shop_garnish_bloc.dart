import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shop_garnish/add_shop_garnish_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shop_garnish/delete_shop_garnish_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shop_garnish/get_shop_garnish_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shop_garnish/update_quantity_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_state.dart';

class RemoteShopGarnishBloc
    extends Bloc<RemoteShopGarnishEvent, RemoteShopGarnishState> {
  final GetShopGarnishUsecase _getShopGarnishUsecase;
  final UpdateQuantityUsecase _updateQuantityUsecase;
  final AddShopGarnishUsecase _addShopGarnishUsecase;
  final DeleteShopGarnishUsecase _deleteShopGarnishUsecase;

  RemoteShopGarnishBloc(
      this._getShopGarnishUsecase,
      this._updateQuantityUsecase,
      this._addShopGarnishUsecase,
      this._deleteShopGarnishUsecase)
      : super(const RemoteShopGarnishLoading()) {
    on<GetShopGarnish>(onGetShopGarnish);
    on<UpdateQuantity>(onUpdateQuantity);
    on<AddShopGarnish>(onAddShopGarnish);
    on<DeleteShopGarnish>(onDeleteShopGarnish);
  }

  /// Handles the [GetShopGarnish] event.
  ///
  /// This function calls the [_getShopGarnishUsecase] with the event's id.
  /// If the use case returns a [DataSuccess], it emits a [RemoteShopGarnishDone]
  /// state with the retrieved data. If the use case returns a [DataFailed],
  /// it emits a [RemoteShopGarnishError] state with the error message.
  ///
  /// The [event] parameter contains the [GetShopGarnish] event.
  /// The [emit] parameter is a function used to emit states.
  void onGetShopGarnish(
      GetShopGarnish event, Emitter<RemoteShopGarnishState> emit) async {
    // Call the use case to get shop garnish.
    final dataState = await _getShopGarnishUsecase(params: event.id);

    // If the use case returns a DataSuccess, emit a RemoteShopGarnishDone state
    // with the retrieved data.
    if (dataState is DataSuccess) {
      // Emit the RemoteShopGarnishDone state with the retrieved data.
      emit(RemoteShopGarnishDone(dataState.data!));
    }

    // If the use case returns a DataFailed, emit a RemoteShopGarnishError state
    // with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteShopGarnishError state with the error message.
      emit(RemoteShopGarnishError(dataState.error!));
    }
  }

  /// Handles the [UpdateQuantity] event.
  ///
  /// This function calls the [_updateQuantityUsecase] with the event's [ShopGarnishDTO].
  /// If the use case returns a [DataSuccess], it emits a [RemoteUpdateQuantityDone]
  /// state with the retrieved data. If the use case returns a [DataFailed],
  /// it emits a [RemoteUpdateQuantityError] state with the error message.
  ///
  /// The [event] parameter contains the [UpdateQuantity] event.
  /// The [emit] parameter is a function used to emit states.
  void onUpdateQuantity(
      UpdateQuantity event, Emitter<RemoteShopGarnishState> emit) async {
    // Call the use case to update quantity.
    final dataState =
        await _updateQuantityUsecase(params: event.shopGarnishDTO);

    // If the use case returns a DataSuccess, emit a RemoteUpdateQuantityDone state
    // with the retrieved data.
    if (dataState is DataSuccess) {
      // Emit the RemoteUpdateQuantityDone state with the retrieved data.
      emit(RemoteShopGarnishDone(dataState.data ?? []));
    }

    // If the use case returns a DataFailed, emit a RemoteUpdateQuantityError state
    // with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteUpdateQuantityError state with the error message.
      emit(RemoteShopGarnishError(dataState.error!));
    }
  }

  /// Handles the [AddShopGarnish] event.
  ///
  /// This function calls the [_addShopGarnishUsecase] with the event's [ShopGarnishDTO].
  /// If the use case returns a [DataSuccess], it emits a [RemoteAddShopGarnishDone]
  /// state with the retrieved data. If the use case returns a [DataFailed],
  /// it emits a [RemoteAddShopGarnishError] state with the error message.
  ///
  /// The [event] parameter contains the [AddShopGarnish] event.
  /// The [emit] parameter is a function used to emit states.
  void onAddShopGarnish(
      AddShopGarnish event, Emitter<RemoteShopGarnishState> emit) async {
    // Call the use case to add shop garnish.
    final dataState =
        await _addShopGarnishUsecase(params: event.shopGarnishDTO);

    // If the use case returns a DataSuccess, emit a RemoteAddShopGarnishDone state
    // with the retrieved data.
    if (dataState is DataSuccess) {
      // Emit the RemoteAddShopGarnishDone state with the retrieved data.
      emit(RemoteAddShopGarnishDone(dataState.data!));
    }

    // If the use case returns a DataFailed, emit a RemoteAddShopGarnishError state
    // with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteAddShopGarnishError state with the error message.
      emit(RemoteShopGarnishError(dataState.error!));
    }
  }

  /// Handles the [DeleteShopGarnish] event.
  ///
  /// This function calls the [_deleteShopGarnishUsecase] with the event's [int].
  /// If the use case returns a [DataSuccess], it emits a [RemoteDeleteShopGarnishDone]
  /// state with the retrieved data. If the use case returns a [DataFailed],
  /// it emits a [RemoteDeleteShopGarnishError] state with the error message.
  ///
  /// The [event] parameter contains the [DeleteShopGarnish] event.
  /// The [emit] parameter is a function used to emit states.
  void onDeleteShopGarnish(
      DeleteShopGarnish event, Emitter<RemoteShopGarnishState> emit) async {
    // Call the use case to delete shop garnish.
    final dataState = await _deleteShopGarnishUsecase(params: event.id);

    // If the use case returns a DataSuccess, emit a RemoteDeleteShopGarnishDone state
    // with the retrieved data.
    if (dataState is DataSuccess) {
      // Emit the RemoteDeleteShopGarnishDone state with the retrieved data.
      emit(const RemoteDeleteShopGarnishDone());
    }

    // If the use case returns a DataFailed, emit a RemoteDeleteShopGarnishError state
    // with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteDeleteShopGarnishError state with the error message.
      emit(RemoteShopGarnishError(dataState.error!));
    }
  }
}
