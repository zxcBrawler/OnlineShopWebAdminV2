import 'package:xc_web_admin/feature/shared/data/model/clothes_size_clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/user.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/cart_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    int? id,
    UserEntity? user,
    ClothesSizeClothesEntity? sizeClothes,
    int? quantity,
  }) : super(id: id, user: user, sizeClothes: sizeClothes, quantity: quantity);

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      id: map["id"],
      user: UserModel.fromJson(map["user"]),
      sizeClothes: ClothesSizeClothesModel.fromJson(map["sizeClothes"]),
    );
  }

  factory CartModel.fromEntity(CartEntity cartEntity) {
    return CartModel(
        id: cartEntity.id,
        user: cartEntity.user,
        sizeClothes: cartEntity.sizeClothes,
        quantity: cartEntity.quantity);
  }
}
