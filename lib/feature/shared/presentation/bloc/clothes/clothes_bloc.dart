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

  void onGetClothes(GetClothes event, Emitter<RemoteClothesState> emit) async {
    final dataState = await _getClothesUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);
      emit(RemoteClothesDone(dataState.data!));
    }
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emit(RemoteClothesError(dataState.error!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteClothesError(dataState.error!));
    }
  }

  void onGetClothesColors(
      GetClothesColors event, Emitter<RemoteClothesState> emit) async {
    final dataState = await _getClothesColorsUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);
      emit(RemoteClothesColorsDone(dataState.data!));
    }
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emit(RemoteClothesError(dataState.error!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteClothesError(dataState.error!));
    }
  }

  void onGetClothesSizes(
      GetClothesSizes event, Emitter<RemoteClothesState> emit) async {
    final dataState = await _getClothesSizesUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);
      emit(RemoteClothesSizeClothesDone(dataState.data!));
    }
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emit(RemoteClothesError(dataState.error!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteClothesError(dataState.error!));
    }
  }

  void onGetClothesPhotos(
      GetClothesPhoto event, Emitter<RemoteClothesState> emit) async {
    final dataState = await _getClothesPhotosUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);
      emit(RemotePhotosOfClothesDone(dataState.data!));
    }
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emit(RemoteClothesError(dataState.error!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteClothesError(dataState.error!));
    }
  }
}
