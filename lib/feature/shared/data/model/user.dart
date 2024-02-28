import 'package:xc_web_admin/feature/shared/data/model/category_clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/role.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/category_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/role_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    int? id,
    String? username,
    String? passwordHash,
    String? email,
    String? phoneNumber,
    String? profilePhoto,
    String? employeeNumber,
    RoleEntity? role,
    CategoryClothesEntity? gender,
  }) : super(
            id: id,
            username: username,
            passwordHash: passwordHash,
            email: email,
            phoneNumber: phoneNumber,
            profilePhoto: profilePhoto,
            employeeNumber: employeeNumber,
            role: role,
            gender: gender);

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        id: map["id"],
        username: map["username"],
        passwordHash: map["passwordHash"],
        email: map["email"],
        phoneNumber: map["phoneNumber"],
        profilePhoto: map["profilePhoto"],
        employeeNumber: map["employeeNumber"],
        role: RoleModel.fromJson(map["role"]),
        gender: CategoryClothesModel.fromJson(map["gender"]));
  }
}
