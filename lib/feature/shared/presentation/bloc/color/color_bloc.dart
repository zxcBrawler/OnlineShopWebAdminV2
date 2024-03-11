import 'package:bloc/bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/color/get_colors_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_state.dart';

class RemoteColorBloc extends Bloc<RemoteColorEvent, RemoteColorState> {
  final GetColorsUsecase _getColorsUsecase;

  RemoteColorBloc(this._getColorsUsecase) : super(const RemoteColorsLoading()) {
    on<GetColors>(onGetColors);
  }

  void onGetColors(GetColors event, Emitter<RemoteColorState> emit) async {
    // Call the use case to get colors.
    final dataState = await _getColorsUsecase();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteColorsDone state.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteColorsDone state with the retrieved data.
      emit(RemoteColorsDone(dataState.data!));
    }
    // If the use case returns a DataFailed,
    // emit a RemoteColorsError state with the error message.
    if (dataState is DataFailed) {
      emit(RemoteColorsError(dataState.error!));
    }
  }
}
