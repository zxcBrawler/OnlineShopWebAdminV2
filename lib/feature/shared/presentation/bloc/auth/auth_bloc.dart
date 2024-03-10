import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/constants/shared_prefs.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/auth/authenticate.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/auth/auth_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Authenticate _authenticate;

  AuthBloc(
    this._authenticate,
  ) : super(const AuthStateLoading()) {
    on<Login>(onLogin);
  }

  /// Handles the [Login] event.
  ///
  /// Emits the appropriate [AuthState] based on the result of the authentication.
  ///
  /// Saves the access token and username to shared preferences if the authentication is successful.
  /// Navigates to the admin dashboard if the access token is not empty.
  /// Prints the error if the authentication fails.
  void onLogin(Login event, Emitter<AuthState> emit) async {
    // Authenticate the user with the provided login details.
    final dataState = await _authenticate(params: event.loginDTO);

    // If the authentication is successful, save the access token and username to shared preferences.
    // Navigate to the admin dashboard.
    if (dataState is DataSuccess) {
      accessToken = dataState.data?.accessToken ?? "";
      username = event.loginDTO!.username;
      SharedPreferencesManager.saveAccessToken(
          <String, String>{accessToken!: username!});

      if (accessToken != "") {
        router.go(Pages.adminDashboard.screenPath);
      }

      // Emit the [AuthStateDone] state with the authentication data.
      emit(AuthStateDone(dataState.data!));
    }

    // Emit the [AuthStateError] state with the error message.
    if (dataState is DataFailed) {
      emit(AuthStateError(dataState.error!));
    }
  }
}
