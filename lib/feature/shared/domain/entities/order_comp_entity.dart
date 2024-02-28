import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';

class OrderCompositionEntity {
  final int? orderCompId;
  final ClothesEntity? clothesComp;
  final SizeClothesEntity? sizeClothes;
  final ColorEntity? colorClothes;
  final OrderEntity? orderId;
  final int? quantity;

  const OrderCompositionEntity(
      {this.orderCompId,
      this.clothesComp,
      this.sizeClothes,
      this.colorClothes,
      this.orderId,
      this.quantity});
}
