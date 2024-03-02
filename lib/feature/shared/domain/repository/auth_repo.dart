import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_dto.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_responce.dart';

abstract class AuthRepo {
  Future<DataState<LoginResponse>> authorize({LoginDTO? loginDTO});
  Future<DataState<void>> logout();
}
