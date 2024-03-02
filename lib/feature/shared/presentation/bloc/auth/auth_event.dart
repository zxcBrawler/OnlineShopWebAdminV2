import 'package:xc_web_admin/feature/shared/data/dto/login_dto.dart';

abstract class AuthEvent {
  final dynamic param;
  const AuthEvent({this.param});
}

class Login extends AuthEvent {
  final LoginDTO? loginDTO;
  const Login({this.loginDTO});
}
