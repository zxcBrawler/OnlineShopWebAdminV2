import 'package:xc_web_admin/feature/shared/data/model/address.dart';
import 'package:xc_web_admin/feature/shared/data/model/user.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class UserAddressModel extends UserAddressEntity {
  const UserAddressModel({
    int? userAddressId,
    UserEntity? user,
    AddressEntity? address,
  }) : super(userAddressId: userAddressId, user: user, address: address);

  factory UserAddressModel.fromJson(Map<String, dynamic> map) {
    return UserAddressModel(
        userAddressId: map["userAddressId"],
        user: UserModel.fromJson(map["user"]),
        address: AddressModel.fromJson(map["address"]));
  }
}
