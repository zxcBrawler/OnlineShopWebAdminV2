import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/get_clothes_colors_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/get_clothes_photos_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/get_clothes_sizes_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/get_clothes_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';

class RemoteClothesBloc extends Bloc<RemoteClothesEvent, RemoteClothesState> {
  final GetClothesUsecase _getClothesUsecase;
  final GetClothesColorsUsecase _getClothesColorsUsecase;
  final GetClothesSizesUsecase _getClothesSizesUsecase;
  final GetClothesPhotosUsecase _getClothesPhotosUsecase;

  RemoteClothesBloc(this._getClothesUsecase, this._getClothesColorsUsecase,
      this._getClothesSizesUsecase, this._getClothesPhotosUsecase)
      : super(const RemoteClothesLoading()) {
    on<GetClothes>(onGetClothes);
    on<GetClothesColors>(onGetClothesColors);
    on<GetClothesSizes>(onGetClothesSizes);
    on<GetClothesPhoto>(onGetClothesPhotos);
  }

  /// Handles the event [GetClothes] by calling the [_getClothesUsecase] and
  /// emitting the appropriate state.
  ///
  /// It emits a [RemoteClothesDone] state if the [_getClothesUsecase]
  /// returns a [DataSuccess] with non-empty data. It emits a
  /// [RemoteClothesError] state if the [_getClothesUsecase]
  /// returns a [DataFailed] or a [DataSuccess] with empty data.
  void onGetClothes(GetClothes event, Emitter<RemoteClothesState> emit) async {
    // Call the use case to get clothes data.
    final dataState = await _getClothesUsecase();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteClothesDone state.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteClothesDone state with the retrieved data.
      emit(RemoteClothesDone(dataState.data!));
    }

    // If the use case returns a DataFailed or a DataSuccess with empty data,
    // emit a RemoteClothesError state.
    if (dataState is DataFailed ||
        (dataState is DataSuccess && dataState.data!.isEmpty)) {
      // Emit the RemoteClothesError state with the error message.
      emit(RemoteClothesError(dataState.error!));
    }
  }

  /// Handles the event [GetClothesColors] by calling the [_getClothesColorsUsecase]
  /// and emitting the appropriate state.
  ///
  /// It emits a [RemoteClothesColorsDone] state if the [_getClothesColorsUsecase]
  /// returns a [DataSuccess] with non-empty data. It emits a
  /// [RemoteClothesError] state if the [_getClothesColorsUsecase]
  /// returns a [DataSuccess] with empty data or a [DataFailed].
  void onGetClothesColors(
      GetClothesColors event, Emitter<RemoteClothesState> emit) async {
    // Call the use case to get clothes colors.
    final dataState = await _getClothesColorsUsecase(params: event.id);

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteClothesColorsDone state.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteClothesColorsDone state with the retrieved data.
      emit(RemoteClothesColorsDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data or a DataFailed,
    // emit a RemoteClothesError state.
    if (dataState is DataSuccess && dataState.data!.isEmpty ||
        dataState is DataFailed) {
      // Emit the RemoteClothesError state with the error message.
      emit(RemoteClothesError(dataState.error!));
    }
  }

  /// Handles the event [GetClothesSizes] by calling the [_getClothesSizesUsecase]
  /// and emitting the appropriate state.
  ///
  /// It emits a [RemoteClothesSizeClothesDone] state if the
  /// [_getClothesSizesUsecase] returns a [DataSuccess] with non-empty data.
  /// It emits a [RemoteClothesError] state if the [_getClothesSizesUsecase]
  /// returns a [DataSuccess] with empty data or a [DataFailed].
  ///
  /// The [event] parameter contains the id of the clothes.
  /// The [emit] parameter is a function used to emit states.
  void onGetClothesSizes(
      GetClothesSizes event, Emitter<RemoteClothesState> emit) async {
    // Call the use case to get clothes sizes.
    final dataState = await _getClothesSizesUsecase(params: event.id);

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteClothesSizeClothesDone state.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteClothesSizeClothesDone state with the retrieved data.
      emit(RemoteClothesSizeClothesDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data or a DataFailed,
    // emit a RemoteClothesError state.
    if (dataState is DataSuccess && dataState.data!.isEmpty ||
        dataState is DataFailed) {
      // Emit the RemoteClothesError state with the error message.
      emit(RemoteClothesError(dataState.error!));
    }
  }

  /// Handles the event [GetClothesPhotos] by calling the [_getClothesPhotosUsecase]
  /// and emits the appropriate state.
  ///
  /// It emits a [RemotePhotosOfClothesDone] state if the
  /// [_getClothesPhotosUsecase] returns a [DataSuccess] with non-empty data.
  /// It emits a [RemoteClothesError] state if the [_getClothesPhotosUsecase]
  /// returns a [DataSuccess] with empty data or a [DataFailed].
  ///
  /// The [event] parameter contains the id of the clothes.
  /// The [emit] parameter is a function used to emit states.
  void onGetClothesPhotos(
      GetClothesPhoto event, Emitter<RemoteClothesState> emit) async {
    // Call the use case to get clothes photos.
    final dataState = await _getClothesPhotosUsecase(params: event.id);

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemotePhotosOfClothesDone state.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemotePhotosOfClothesDone state with the retrieved data.
      emit(RemotePhotosOfClothesDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data,
    // emit a RemoteClothesError state.
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      // Emit the RemoteClothesError state with the error message.
      emit(RemoteClothesError(dataState.error!));
    }

    // If the use case returns a DataFailed,
    // emit a RemoteClothesError state.
    if (dataState is DataFailed) {
      // Emit the RemoteClothesError state with the error message.
      emit(RemoteClothesError(dataState.error!));
    }
  }
}
