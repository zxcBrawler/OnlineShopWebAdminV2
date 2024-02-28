import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/role/get_roles_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/role/role_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/role/role_state.dart';

class RemoteRoleBloc extends Bloc<RemoteRoleEvent, RemoteRoleState> {
  final GetRolesUsecase _getRolesUsecase;

  RemoteRoleBloc(this._getRolesUsecase) : super(const RemoteRoleLoading()) {
    on<GetRoles>(onGetRoles);
  }

  void onGetRoles(GetRoles event, Emitter<RemoteRoleState> emit) async {
    final dataState = await _getRolesUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);
      emit(RemoteRoleDone(dataState.data!));
    }
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emit(RemoteRoleError(dataState.error!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteRoleError(dataState.error!));
    }
  }
}
