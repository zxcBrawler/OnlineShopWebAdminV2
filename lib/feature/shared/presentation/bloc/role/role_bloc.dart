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

  /// Handles the [GetRoles] event by calling the [_getRolesUsecase]
  /// and emitting the appropriate state.
  ///
  /// If the [_getRolesUsecase] returns a [DataSuccess] with non-empty data,
  /// it emits a [RemoteRoleDone] state with the retrieved data.
  /// If the [_getRolesUsecase] returns a [DataSuccess] with empty data,
  /// it emits a [RemoteRoleError] state with the error message.
  /// If the [_getRolesUsecase] returns a [DataFailed],
  /// it emits a [RemoteRoleError] state with the error message.
  ///
  /// The [event] parameter contains the [GetRoles] event.
  /// The [emit] parameter is a function used to emit states.
  void onGetRoles(GetRoles event, Emitter<RemoteRoleState> emit) async {
    // Call the use case to get roles.
    final dataState = await _getRolesUsecase();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteRoleDone state with the retrieved data.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteRoleDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data or a DataFailed,
    // emit a RemoteRoleError state with the error message.
    if (dataState is DataSuccess && dataState.data!.isEmpty ||
        dataState is DataFailed) {
      emit(RemoteRoleError(dataState.error!));
    }
  }
}
