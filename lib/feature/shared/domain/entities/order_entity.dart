import 'package:xc_web_admin/feature/shared/domain/entities/status_order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_card_entity.dart';

class OrderEntity {
  final int? idOrder;
  final String? numberOrder;
  final String? timeOrder;
  final String? dateOrder;
  final String? sumOrder;
  final StatusOrderEntity? currentStatus;
  final UserCardEntity? userCard;

  const OrderEntity(
      {this.idOrder,
      this.numberOrder,
      this.timeOrder,
      this.dateOrder,
      this.sumOrder,
      this.currentStatus,
      this.userCard});
}
