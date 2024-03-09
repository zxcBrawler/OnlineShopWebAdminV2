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

  void onLogin(Login event, Emitter<AuthState> emit) async {
    final dataState = await _authenticate(params: event.loginDTO);
    if (dataState is DataSuccess) {
      accessToken = dataState.data?.accessToken ?? "";
      username = event.loginDTO!.username;
      SharedPreferencesManager.saveAccessToken(
          <String, String>{accessToken!: username!});

      if (accessToken != "") {
        router.go(Pages.adminDashboard.screenPath);
      }

      emit(AuthStateDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.error);
      emit(AuthStateError(dataState.error!));
    }
  }
}
