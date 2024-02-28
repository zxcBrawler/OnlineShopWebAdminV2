import 'package:xc_web_admin/feature/shared/domain/entities/category_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/role_entity.dart';

class UserEntity {
  final int? id;
  final String? username;
  final String? passwordHash;
  final String? email;
  final String? phoneNumber;
  final String? profilePhoto;
  final String? employeeNumber;
  final RoleEntity? role;
  final CategoryClothesEntity? gender;

  const UserEntity(
      {this.id,
      this.username,
      this.passwordHash,
      this.email,
      this.phoneNumber,
      this.profilePhoto,
      this.employeeNumber,
      this.role,
      this.gender});

  List<String> getProperties() {
    return [
      'username',
      'email',
      'phone number',
      'employee number',
      'role name',
      'gender',
    ];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'username':
        return username;

      case 'email':
        return email;
      case 'phone number':
        return phoneNumber;

      case 'employee number':
        return employeeNumber;
      case 'role name':
        return role?.roleName;
      case 'gender':
        return gender?.nameCategory;
      // Replace with other property names
      // ... handle other properties ...
      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
