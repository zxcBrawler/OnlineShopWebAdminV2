import 'package:xc_web_admin/feature/shared/data/model/clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/color.dart';
import 'package:xc_web_admin/feature/shared/data/model/order.dart';
import 'package:xc_web_admin/feature/shared/data/model/size_clothes.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';

class OrderCompositionModel extends OrderCompositionEntity {
  const OrderCompositionModel({
    int? orderCompId,
    ClothesEntity? clothesComp,
    SizeClothesEntity? sizeClothes,
    ColorEntity? colorClothes,
    OrderEntity? orderId,
    int? quantity,
  }) : super(
            orderCompId: orderCompId,
            clothesComp: clothesComp,
            sizeClothes: sizeClothes,
            colorClothes: colorClothes,
            orderId: orderId,
            quantity: quantity);

  factory OrderCompositionModel.fromJson(Map<String, dynamic> map) {
    return OrderCompositionModel(
        orderCompId: map["orderCompId"],
        clothesComp: ClothesModel.fromJson(map["clothesComp"]),
        sizeClothes: SizeClothesModel.fromJson(map["sizeClothes"]),
        colorClothes: ColorModel.fromJson(map["colorClothes"]),
        orderId: OrderModel.fromJson(map["orderId"]),
        quantity: map["quantity"]);
  }
}
