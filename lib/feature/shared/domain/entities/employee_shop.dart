import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class EmployeeShopEntity {
  final int? id;
  final UserEntity? employee;
  final ShopAddressEntity? shopAddresses;

  const EmployeeShopEntity({this.id, this.employee, this.shopAddresses});
}
