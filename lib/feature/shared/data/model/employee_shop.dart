import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';
import 'package:xc_web_admin/feature/shared/data/model/user.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/employee_shop.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class EmployeeShopModel extends EmployeeShopEntity {
  const EmployeeShopModel({
    int? id,
    UserEntity? employee,
    ShopAddressEntity? shopAddress,
  }) : super(id: id, employee: employee, shopAddresses: shopAddress);

  factory EmployeeShopModel.fromJson(Map<String, dynamic> map) {
    return EmployeeShopModel(
        id: map["id"],
        employee: UserModel.fromJson(map["employee"]),
        shopAddress: ShopAddressModel.fromJson(map["shopAddress"]));
  }
}
