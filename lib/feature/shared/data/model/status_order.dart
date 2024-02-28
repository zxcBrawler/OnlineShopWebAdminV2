import 'package:xc_web_admin/feature/shared/domain/entities/status_order_entity.dart';

class StatusOrderModel extends StatusOrderEntity {
  const StatusOrderModel({int? idStatus, String? nameStatus})
      : super(idStatus: idStatus, nameStatus: nameStatus);

  factory StatusOrderModel.fromJson(Map<String, dynamic> map) {
    return StatusOrderModel(
        idStatus: map["idStatus"], nameStatus: map["nameStatus"]);
  }
}
