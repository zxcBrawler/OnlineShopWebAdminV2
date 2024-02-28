import 'package:xc_web_admin/feature/shared/data/model/status_order.dart';
import 'package:xc_web_admin/feature/shared/data/model/user_card.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/status_order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_card_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    int? idOrder,
    String? numberOrder,
    String? timeOrder,
    String? dateOrder,
    String? sumOrder,
    StatusOrderEntity? currentStatus,
    UserCardEntity? userCard,
  }) : super(
            idOrder: idOrder,
            numberOrder: numberOrder,
            timeOrder: timeOrder,
            dateOrder: dateOrder,
            sumOrder: sumOrder,
            currentStatus: currentStatus,
            userCard: userCard);

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
        idOrder: map["idOrder"],
        numberOrder: map["numberOrder"],
        timeOrder: map["timeOrder"],
        dateOrder: map["dateOrder"],
        sumOrder: map["sumOrder"],
        currentStatus: StatusOrderModel.fromJson(map["currentStatus"]),
        userCard: UserCardModel.fromJson(map["userCard"]));
  }
}
