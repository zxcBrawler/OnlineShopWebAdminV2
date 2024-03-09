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

  /// Handles the [GetUsers] event by calling the [_getUsersUsecase].
  ///
  /// Emits a [RemoteUserDone] state with the retrieved data if
  /// the [_getUsersUsecase] returns a [DataSuccess] with non-empty data.
  /// Emits a [RemoteUserError] state with the error message if
  /// the [_getUsersUsecase] returns a [DataSuccess] with empty data or a [DataFailed].
  ///
  /// The [event] parameter contains the [GetUsers] event.
  /// The [emitter] parameter is a function used to emit states.
  void onGetUsers(GetUsers event, Emitter<RemoteUserState> emitter) async {
    // Call the use case to get users.
    final dataState = await _getUsersUsecase();

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteUserDone state with the retrieved data.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteUserDone state with the retrieved data.
      emitter(RemoteUserDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data or a DataFailed,
    // emit a RemoteUserError state with the error message.
    if (dataState is DataSuccess && dataState.data!.isEmpty ||
        dataState is DataFailed) {
      // Emit the RemoteUserError state with the error message.
      emitter(RemoteUserError(dataState.error!));
    }
  }

  /// Handles the [AddUser] event.
  ///
  /// Calls the [_addUserUsecase] to add a user with the given [event.user] data.
  /// Emits a [RemoteAddUserDone] state with the added data if the operation is successful.
  /// Emits a [RemoteUserError] state with the error message if the operation fails.
  ///
  /// Parameters:
  /// - [event]: The [AddUser] event containing the user data to be added.
  /// - [emitter]: The state emitter used to emit states.
  void onAddUser(AddUser event, Emitter<RemoteUserState> emitter) async {
    // Call the add user use case with the provided user data.
    final dataState = await _addUserUsecase(params: event.user);

    // If the use case returns a DataSuccess, emit a RemoteAddUserDone state
    // with the added data.
    if (dataState is DataSuccess) {
      // Emit the RemoteAddUserDone state with the added data.
      emitter(RemoteAddUserDone(dataState.data!));
    }

    // If the use case returns a DataFailed, emit a RemoteUserError state
    // with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteUserError state with the error message.
      emitter(RemoteUserError(dataState.error!));
    }
  }

  /// Handles the [UpdateUser] event.
  ///
  /// Calls the [_updateUserUsecase] to update a user with the given [event.user]
  /// data. Emits a [RemoteAddUserDone] state if the update operation is
  /// successful, otherwise emits a [RemoteUserError] state with the error message.
  ///
  /// Parameters:
  /// - [event]: The [UpdateUser] event containing the user data to be updated.
  /// - [emitter]: The state emitter used to emit states.
  void onUpdateUser(UpdateUser event, Emitter<RemoteUserState> emitter) async {
    // Call the update user use case with the provided user data.
    final dataState = await _updateUserUsecase(params: event.user);

    // If the use case returns a DataSuccess, emit a RemoteAddUserDone state
    // with the updated data.
    if (dataState is DataSuccess) {
      // Emit the RemoteAddUserDone state with the updated data.
      emitter(RemoteAddUserDone(dataState.data!));
    }

    // If the use case returns a DataFailed, emit a RemoteUserError state
    // with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteUserError state with the error message.
      emitter(RemoteUserError(dataState.error!));
    }
  }

  /// Handles the [DeleteUser] event.
  ///
  /// Calls the [_deleteUserUsecase] to delete a user with the given [event.id].
  /// Emits a [RemoteDeleteUserDone] state if the delete operation is successful,
  /// otherwise emits a [RemoteUserError] state with the error message.
  ///
  /// Parameters:
  /// - [event]: The [DeleteUser] event containing the id of the user to be deleted.
  /// - [emitter]: The state emitter used to emit states.
  void onDeleteUser(DeleteUser event, Emitter<RemoteUserState> emitter) async {
    // Call the use case to delete the user with the given id.
    final dataState = await _deleteUserUsecase(params: event.id);

    // If the use case returns a DataSuccess,
    // emit a RemoteDeleteUserDone state.
    if (dataState is DataSuccess) {
      // Emit the RemoteDeleteUserDone state.
      emitter(const RemoteDeleteUserDone());
    }

    // If the use case returns a DataFailed,
    // emit a RemoteUserError state with the error message.
    if (dataState is DataFailed) {
      // Emit the RemoteUserError state with the error message.
      emitter(RemoteUserError(dataState.error!));
    }
  }
}
