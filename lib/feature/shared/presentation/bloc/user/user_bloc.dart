import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/add_user_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/get_users_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_state.dart';

class RemoteUserBloc extends Bloc<RemoteUserEvent, RemoteUserState> {
  final GetUsersUsecase _getUsersUsecase;
  final AddUserUsecase _addUserUsecase;

  RemoteUserBloc(this._getUsersUsecase, this._addUserUsecase)
      : super(const RemoteUserLoading()) {
    on<GetUsers>(onGetUsers);
    on<AddUser>(onAddUser);
  }

  void onGetUsers(GetUsers event, Emitter<RemoteUserState> emitter) async {
    final dataState = await _getUsersUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emitter(RemoteUserDone(dataState.data!));
    }
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emitter(RemoteUserError(dataState.error!));
    }
    if (dataState is DataFailed) {
      emitter(RemoteUserError(dataState.error!));
    }
  }

  void onAddUser(AddUser event, Emitter<RemoteUserState> emitter) async {
    final dataState = await _addUserUsecase(params: event.user);
    if (dataState is DataSuccess) {
      emitter(RemoteAddUserDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emitter(RemoteUserError(dataState.error!));
    }
  }
}
