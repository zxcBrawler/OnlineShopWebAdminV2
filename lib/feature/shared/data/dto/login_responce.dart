import 'package:xc_web_admin/feature/shared/data/model/user.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class LoginResponse {
  final UserEntity? userEntity;
  final String? accessToken;

  LoginResponse({this.userEntity, this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> map) {
    return LoginResponse(
      userEntity: UserModel.fromJson(map["user"]),
      accessToken: map["accessToken"],
    );
  }
}
