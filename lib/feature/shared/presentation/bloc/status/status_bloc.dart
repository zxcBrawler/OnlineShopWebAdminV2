import 'package:bloc/bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/status/get_statuses_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/status/update_status_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/status/status_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/status/status_state.dart';

class RemoteStatusBloc extends Bloc<RemoteStatusEvent, RemoteStatusState> {
  final GetStatusesUsecase _getStatuses;
  final UpdateStatusUsecase _updateStatus;
  RemoteStatusBloc(this._getStatuses, this._updateStatus)
      : super(const RemoteStatusLoading()) {
    on<GetStatuses>(onGetStatuses);
    on<UpdateStatues>(onUpdateStatus);
  }

  /// Handles the [GetStatuses] event.
  ///
  /// Calls the [_getStatuses] use case to retrieve a list of statuses.
  /// If the use case returns a [DataSuccess] with a non-empty data,
  /// it emits a [RemoteStatusDone] state with the retrieved data.
  /// If the use case returns a [DataFailed], it emits a [RemoteStatusError]
  /// state with the error message.
  ///
  /// The [event] parameter is the [GetStatuses] event.
  /// The [emit] parameter is a function used to emit states.
  void onGetStatuses(GetStatuses event, Emitter<RemoteStatusState> emit) async {
    // Call the use case to get the list of statuses.
    final dataState = await _getStatuses();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteStatusDone state with the retrieved data.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteStatusDone(dataState.data!));
    }
    // If the use case returns a DataFailed,
    // emit a RemoteStatusError state with the error message.
    else if (dataState is DataFailed) {
      emit(RemoteStatusError(dataState.error!));
    }
  }

  /// Handles the [UpdateStatues] event.
  ///
  /// Calls the [_updateStatus] use case to update a status with the given
  /// [event.statusDTO] data. Emits a [RemoteStatusDone] state if the update
  /// operation is successful, otherwise emits a [RemoteStatusError] state
  /// with the error message.
  ///
  /// Parameters:
  /// - [event]: The [UpdateStatues] event containing the status data to
  /// be updated.
  /// - [emit]: The state emitter used to emit states.
  void onUpdateStatus(
      UpdateStatues event, Emitter<RemoteStatusState> emit) async {
    // Call the update status use case with the provided status data.
    final dataState = await _updateStatus(params: event.statusDTO);

    // If the use case returns a DataSuccess, emit a RemoteStatusDone state
    // with the updated data.
    if (dataState is DataSuccess) {
      // Emit the RemoteStatusDone state with the updated data.
      emit(RemoteStatusDone(dataState.data ?? []));
    }

    // If the use case returns a DataFailed, emit a RemoteStatusError state
    // with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteStatusError state with the error message.
      emit(RemoteStatusError(dataState.error!));
    }
  }
}
