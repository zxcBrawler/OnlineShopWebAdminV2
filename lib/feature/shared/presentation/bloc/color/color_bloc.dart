import 'package:bloc/bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/color/add_color_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/color/get_colors_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_state.dart';

class RemoteColorBloc extends Bloc<RemoteColorEvent, RemoteColorState> {
  final GetColorsUsecase _getColorsUsecase;
  final AddColorUsecase _addColorUsecase;

  RemoteColorBloc(this._getColorsUsecase, this._addColorUsecase)
      : super(const RemoteColorsLoading()) {
    on<GetColors>(onGetColors);
    on<AddColor>(onAddColor);
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

  void onAddColor(AddColor event, Emitter<RemoteColorState> emit) async {
    // Call the use case to add color.
    final dataState = await _addColorUsecase(params: event.color);

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteAddColorDone state.
    if (dataState is DataSuccess) {
      // Emit the RemoteAddColorDone state with the retrieved data.
      emit(RemoteAddColorDone(dataState.data!));
    }
    // If the use case returns a DataFailed,
    // emit a RemoteColorsError state with the error message.
    if (dataState is DataFailed) {
      emit(RemoteColorsError(dataState.error!));
    }
  }
}
