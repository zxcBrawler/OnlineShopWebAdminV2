import 'package:xc_web_admin/feature/shared/domain/entities/clothes_colors_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class CartEntity {
  final int? id;
  final UserEntity? user;
  final ClothesSizeClothesEntity? sizeClothes;
  final ClothesColorsEntity? colorClothesCart;
  final int? quantity;

  const CartEntity(
      {this.id,
      this.user,
      this.sizeClothes,
      this.colorClothesCart,
      this.quantity});
}
