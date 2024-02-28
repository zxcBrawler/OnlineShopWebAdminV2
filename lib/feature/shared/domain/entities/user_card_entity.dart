import 'package:xc_web_admin/feature/shared/domain/entities/card_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

class UserCardEntity {
  final int? id;
  final UserEntity? user;
  final CardEntity? card;

  const UserCardEntity({this.id, this.user, this.card});
}
