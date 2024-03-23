import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/orderComp/get_order_comp_by_order_id_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/orderComp/get_order_comp_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_state.dart';

class RemoteOrderCompBloc
    extends Bloc<RemoteOrderCompEvent, RemoteOrderCompState> {
  final GetOrderCompUsecase _getOrderCompUsecase;
  final GetOrderCompByOrderIdUsecase _getOrderCompByOrderIdUsecase;

  RemoteOrderCompBloc(
      this._getOrderCompUsecase, this._getOrderCompByOrderIdUsecase)
      : super(const RemoteOrderCompLoading()) {
    on<GetOrderComp>(onGetOrderComp);
    on<GetOrderCompByOrderId>(onGetOrderCompById);
  }

  /// Handles the [GetOrderComp] event by calling the [_getOrderCompUsecase]
  /// and emitting the appropriate state.
  ///
  /// If the [_getOrderCompUsecase] returns a [DataSuccess] with non-empty data,
  /// it emits a [RemoteOrderCompDone] state with the retrieved data.
  /// If the [_getOrderCompUsecase] returns a [DataSuccess] with empty data,
  /// it emits a [RemoteOrderCompError] state with the error message.
  /// If the [_getOrderCompUsecase] returns a [DataFailed],
  /// it emits a [RemoteOrderCompError] state with the error message.
  ///
  /// The [event] parameter contains the [GetOrderComp] event.
  /// The [emit] parameter is a function used to emit states.
  void onGetOrderComp(
      GetOrderComp event, Emitter<RemoteOrderCompState> emit) async {
    // Call the use case to get order composition.
    final dataState = await _getOrderCompUsecase();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteOrderCompDone state with the retrieved data.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteOrderCompDone state with the retrieved data.
      emit(RemoteOrderCompDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data,
    // emit a RemoteOrderCompError state with the error message.
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      // Emit the RemoteOrderCompError state with the error message.
      emit(const RemoteOrderCompDone([]));
    }

    // If the use case returns a DataFailed,
    // emit a RemoteOrderCompError state with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteOrderCompError state with the error message.
      emit(RemoteOrderCompError(dataState.error!));
    }
  }

  /// Handles the [GetOrderCompByOrderId] event by calling the
  /// [_getOrderCompByOrderIdUsecase] and emitting the appropriate state.
  ///
  /// If the [_getOrderCompByOrderIdUsecase] returns a [DataSuccess] with non-empty data,
  /// it emits a [RemoteOrderCompDone] state with the retrieved data.
  /// If the [_getOrderCompByOrderIdUsecase] returns a [DataSuccess] with empty data,
  /// it emits a [RemoteOrderCompError] state with the error message.
  /// If the [_getOrderCompByOrderIdUsecase] returns a [DataFailed],
  /// it emits a [RemoteOrderCompError] state with the error message.
  ///
  /// The [event] parameter contains the [GetOrderCompByOrderId] event.
  /// The [emit] parameter is a function used to emit states.
  void onGetOrderCompById(
      GetOrderCompByOrderId event, Emitter<RemoteOrderCompState> emit) async {
    // Call the use case to get order composition.
    final dataState = await _getOrderCompByOrderIdUsecase(params: event.id);

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteOrderCompDone state with the retrieved data.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteOrderCompDone state with the retrieved data.
      emit(RemoteOrderCompDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data,
    // emit a RemoteOrderCompError state with the error message.
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      // Emit the RemoteOrderCompError state with the error message.
      emit(const RemoteOrderCompDone([]));
    }

    // If the use case returns a DataFailed,
    // emit a RemoteOrderCompError state with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteOrderCompError state with the error message.
      emit(RemoteOrderCompError(dataState.error!));
    }
  }
}
