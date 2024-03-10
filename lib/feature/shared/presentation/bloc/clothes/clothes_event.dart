import 'package:xc_web_admin/feature/shared/data/dto/add_clothes_dto.dart';

abstract class RemoteClothesEvent {
  final dynamic param;
  const RemoteClothesEvent({this.param});
}

class GetClothes extends RemoteClothesEvent {
  const GetClothes();
}

class AddClothes extends RemoteClothesEvent {
  final ClothesDTO clothesDTO;
  const AddClothes({required this.clothesDTO});
}

class GetClothesColors extends RemoteClothesEvent {
  final int id;
  const GetClothesColors({required this.id});
}

class GetClothesSizes extends RemoteClothesEvent {
  final int id;
  const GetClothesSizes({required this.id});
}

class GetClothesPhoto extends RemoteClothesEvent {
  final int id;
  const GetClothesPhoto({required this.id});
}

class GetTypeClothes extends RemoteClothesEvent {
  final int id;
  const GetTypeClothes({required this.id});
}
