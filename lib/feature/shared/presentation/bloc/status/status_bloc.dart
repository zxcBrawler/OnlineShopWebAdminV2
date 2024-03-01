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

  void onGetStatuses(GetStatuses event, Emitter<RemoteStatusState> emit) async {
    final dataState = await _getStatuses();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteStatusDone(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteStatusError(dataState.error!));
    }
  }

  void onUpdateStatus(
      UpdateStatues event, Emitter<RemoteStatusState> emit) async {
    final dataState = await _updateStatus(params: event.statusDTO);
    if (dataState is DataSuccess) {
      emit(RemoteStatusDone(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteStatusError(dataState.error!));
    }
  }
}
