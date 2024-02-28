import 'package:xc_web_admin/feature/shared/domain/entities/order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class UserOrderEntity {
  final int? userOrderId;
  final UserEntity? user;
  final OrderEntity? order;

  const UserOrderEntity({this.userOrderId, this.user, this.order});
}
