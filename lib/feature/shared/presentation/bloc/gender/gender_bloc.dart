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

  void onGetGenders(GetGenders event, Emitter<RemoteGenderState> emit) async {
    final dataState = await _getGendersUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);
      emit(RemoteGenderDone(dataState.data!));
    }
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emit(RemoteGenderError(dataState.error!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteGenderError(dataState.error!));
    }
  }
}
