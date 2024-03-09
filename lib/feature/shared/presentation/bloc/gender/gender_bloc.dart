import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/gender/get_genders_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_state.dart';

class RemoteGendersBloc extends Bloc<RemoteGenderEvent, RemoteGenderState> {
  final GetGendersUsecase _getGendersUsecase;

  RemoteGendersBloc(this._getGendersUsecase)
      : super(const RemoteGenderLoading()) {
    on<GetGenders>(onGetGenders);
  }

  /// Handles the [GetGenders] event by calling the [_getGendersUsecase]
  /// and emitting the appropriate state.
  ///
  /// If the [_getGendersUsecase] returns a [DataSuccess] with non-empty data,
  /// it emits a [RemoteGenderDone] state with the retrieved data.
  /// If the [_getGendersUsecase] returns a [DataSuccess] with empty data,
  /// it emits a [RemoteGenderError] state with the error message.
  /// If the [_getGendersUsecase] returns a [DataFailed],
  /// it emits a [RemoteGenderError] state with the error message.
  ///
  /// The [event] parameter contains the [GetGenders] event.
  /// The [emit] parameter is a function used to emit states.
  void onGetGenders(GetGenders event, Emitter<RemoteGenderState> emit) async {
    // Call the use case to get genders.
    final dataState = await _getGendersUsecase();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteGenderDone state with the retrieved data.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteGenderDone state with the retrieved data.
      emit(RemoteGenderDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data,
    // emit a RemoteGenderError state with the error message.
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      // Emit the RemoteGenderError state with the error message.
      emit(RemoteGenderError(dataState.error!));
    }

    // If the use case returns a DataFailed,
    // emit a RemoteGenderError state with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteGenderError state with the error message.
      emit(RemoteGenderError(dataState.error!));
    }
  }
}
