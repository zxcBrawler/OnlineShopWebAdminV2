import 'package:xc_web_admin/feature/shared/data/model/order.dart';
import 'package:xc_web_admin/feature/shared/data/model/user.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_order_entitry.dart';

class UserOrderModel extends UserOrderEntity {
  const UserOrderModel({
    int? userOrderId,
    UserEntity? user,
    OrderEntity? order,
  }) : super(userOrderId: userOrderId, user: user, order: order);

  factory UserOrderModel.fromJson(Map<String, dynamic> map) {
    return UserOrderModel(
        userOrderId: map["userOrderId"],
        user: UserModel.fromJson(map["user"]),
        order: OrderModel.fromJson(map["order"]));
  }
}
