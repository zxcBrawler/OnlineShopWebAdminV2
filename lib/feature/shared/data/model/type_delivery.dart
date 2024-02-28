import 'package:xc_web_admin/feature/shared/domain/entities/type_delivery_entity.dart';

class TypeDeliveryModel extends TypeDeliveryEntity {
  const TypeDeliveryModel({
    int? id,
    String? nameType,
  }) : super(id: id, nameType: nameType);

  factory TypeDeliveryModel.fromJson(Map<String, dynamic> map) {
    return TypeDeliveryModel(id: map["id"], nameType: map["nameType"]);
  }
}
