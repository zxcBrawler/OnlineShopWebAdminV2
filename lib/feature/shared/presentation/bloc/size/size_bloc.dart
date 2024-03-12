import 'package:bloc/bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/size/add_size_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/size/get_sizes_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_state.dart';

class RemoteSizeBloc extends Bloc<RemoteSizeEvent, RemoteSizeState> {
  final GetSizesUsecase _getSizesUsecase;
  final AddSizeUsecase _addSizeUsecase;

  RemoteSizeBloc(this._getSizesUsecase, this._addSizeUsecase)
      : super(const RemoteSizesLoading()) {
    on<GetSizes>(onGetSizes);
    on<AddSize>(onAddSize);
  }

  void onGetSizes(GetSizes event, Emitter<RemoteSizeState> emit) async {
    // Call the use case to get sizes.
    final dataState = await _getSizesUsecase();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteSizesDone state.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteSizesDone state with the retrieved data.
      emit(RemoteSizesDone(dataState.data!));
    }
    // If the use case returns a DataFailed,
    // emit a RemoteSizesError state with the error message.
    if (dataState is DataFailed) {
      emit(RemoteSizesError(dataState.error!));
    }
  }

  void onAddSize(AddSize event, Emitter<RemoteSizeState> emit) async {
    // Call the use case to add a size.
    final dataState = await _addSizeUsecase(params: event.size);

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteAddSizeDone state.
    if (dataState is DataSuccess) {
      // Emit the RemoteAddSizeDone state with the retrieved data.
      emit(RemoteAddSizeDone(dataState.data!));
    }
    // If the use case returns a DataFailed,
    // emit a RemoteSizesError state with the error message.
    if (dataState is DataFailed) {
      emit(RemoteSizesError(dataState.error!));
    }
  }
}
