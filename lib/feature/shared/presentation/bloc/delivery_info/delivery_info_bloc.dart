import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/order/get_orders_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';

class RemoteDeliveryInfoBloc
    extends Bloc<RemoteDeliveryInfoEvent, RemoteDeliveryInfoState> {
  final GetDeliveryInfoUsecase _getDeliveryInfoUsecase;

  RemoteDeliveryInfoBloc(this._getDeliveryInfoUsecase)
      : super(const RemoteDeliveryInfoLoading()) {
    on<GetDeliveryInfo>(onGetDeliveryInfo);
  }

  /// Handles the [GetDeliveryInfo] event.
  ///
  /// This method emits the appropriate [RemoteDeliveryInfoState] based on the
  /// result of the delivery information retrieval.
  ///
  /// If the retrieval is successful, it saves the delivery information to
  /// shared preferences and emits a [RemoteDeliveryInfoDone] state.
  /// If the retrieval is unsuccessful, it emits a [RemoteDeliveryInfoError]
  /// state with the error message.
  ///
  /// The [event] parameter contains the `GetDeliveryInfo` event.
  /// The [emit] parameter is a function used to emit states.
  ///
  /// Parameters:
  ///   - [event]: The `GetDeliveryInfo` event containing the necessary data.
  ///   - [emit]: The function used to emit states.
  void onGetDeliveryInfo(
      GetDeliveryInfo event, Emitter<RemoteDeliveryInfoState> emit) async {
    // Call the use case to get delivery information.
    final dataState = await _getDeliveryInfoUsecase();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteDeliveryInfoDone state.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteDeliveryInfoDone state with the retrieved data.
      emit(RemoteDeliveryInfoDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data, emit a
    // RemoteDeliveryInfoError state.
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      // Emit the RemoteDeliveryInfoError state with the error message.
      emit(RemoteDeliveryInfoError(dataState.error!));
    }

    // If the use case returns a DataFailed, emit a RemoteDeliveryInfoError state.
    if (dataState is DataFailed) {
      // Emit the RemoteDeliveryInfoError state with the error message.
      emit(RemoteDeliveryInfoError(dataState.error!));
    }
  }
}
