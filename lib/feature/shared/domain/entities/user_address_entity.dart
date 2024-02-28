import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class UserAddressEntity {
  final int? userAddressId;
  final UserEntity? user;
  final AddressEntity? address;

  const UserAddressEntity({this.userAddressId, this.user, this.address});
}
