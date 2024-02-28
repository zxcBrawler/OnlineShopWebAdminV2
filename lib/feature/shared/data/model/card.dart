import 'package:xc_web_admin/feature/shared/domain/entities/card_entity.dart';

class CardModel extends CardEntity {
  const CardModel({
    int? id,
    String? cardNum,
    String? expDate,
    String? cvv,
  }) : super(id: id, cardNum: cardNum, expDate: expDate, cvv: cvv);

  factory CardModel.fromJson(Map<String, dynamic> map) {
    return CardModel(
      id: map["id"],
      cardNum: map["cardNum"],
      expDate: map["expDate"],
      cvv: map["cvv"],
    );
  }

  factory CardModel.fromEntity(CardEntity cardEntity) {
    return CardModel(
        id: cardEntity.id,
        cardNum: cardEntity.cardNum,
        expDate: cardEntity.expDate,
        cvv: cardEntity.cvv);
  }
}
