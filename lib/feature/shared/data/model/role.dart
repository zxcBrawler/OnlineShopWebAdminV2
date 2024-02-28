import 'package:xc_web_admin/feature/shared/domain/entities/role_entity.dart';

class RoleModel extends RoleEntity {
  const RoleModel({
    int? id,
    String? roleName,
  }) : super(id: id, roleName: roleName);

  factory RoleModel.fromJson(Map<String, dynamic> map) {
    return RoleModel(id: map["id"], roleName: map["roleName"]);
  }
}
