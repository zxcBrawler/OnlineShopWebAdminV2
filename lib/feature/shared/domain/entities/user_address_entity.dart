import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class UserAddressEntity {
  final int? userAddressId;
  final UserEntity? user;
  final AddressEntity? address;

  const UserAddressEntity({this.userAddressId, this.user, this.address});

  List<String> getProperties() {
    return ['address city', 'address direction', 'address name'];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'address city':
        return address!.city;
      case 'address direction':
        return address!.directionAddress;
      case 'address name':
        return address!.nameAddress;

      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
