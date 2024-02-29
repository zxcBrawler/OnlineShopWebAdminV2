abstract class RemoteClothesEvent {
  final dynamic param;
  const RemoteClothesEvent({this.param});
}

class GetClothes extends RemoteClothesEvent {
  const GetClothes();
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
