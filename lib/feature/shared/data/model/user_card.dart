import 'package:xc_web_admin/feature/shared/data/model/card.dart';
import 'package:xc_web_admin/feature/shared/data/model/user.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/card_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_card_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class UserCardModel extends UserCardEntity {
  const UserCardModel({
    int? id,
    UserEntity? user,
    CardEntity? card,
  }) : super(id: id, user: user, card: card);

  factory UserCardModel.fromJson(Map<String, dynamic> map) {
    return UserCardModel(
        id: map["id"],
        user: UserModel.fromJson(map["user"]),
        card: CardModel.fromJson(map["card"]));
  }
}
