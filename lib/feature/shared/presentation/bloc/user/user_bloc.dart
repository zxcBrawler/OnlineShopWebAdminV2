import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/add_user_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/delete_user_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/get_users_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/update_user_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_state.dart';

class RemoteUserBloc extends Bloc<RemoteUserEvent, RemoteUserState> {
  final GetUsersUsecase _getUsersUsecase;
  final AddUserUsecase _addUserUsecase;
  final UpdateUserUsecase _updateUserUsecase;
  final DeleteUserUsecase _deleteUserUsecase;

  RemoteUserBloc(this._getUsersUsecase, this._addUserUsecase,
      this._updateUserUsecase, this._deleteUserUsecase)
      : super(const RemoteUserLoading()) {
    on<GetUsers>(onGetUsers);
    on<AddUser>(onAddUser);
    on<UpdateUser>(onUpdateUser);
    on<DeleteUser>(onDeleteUser);
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
      print(dataState.error);
      emitter(RemoteAddUserDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emitter(RemoteUserError(dataState.error!));
    }
  }

  void onUpdateUser(UpdateUser event, Emitter<RemoteUserState> emitter) async {
    final dataState = await _updateUserUsecase(params: event.user);
    if (dataState is DataSuccess) {
      emitter(RemoteAddUserDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emitter(RemoteUserError(dataState.error!));
    }
  }

  void onDeleteUser(DeleteUser event, Emitter<RemoteUserState> emitter) async {
    final dataState = await _deleteUserUsecase(params: event.id);
    if (dataState is DataSuccess) {
      emitter(const RemoteDeleteUserDone());
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emitter(RemoteUserError(dataState.error!));
    }
  }
}
