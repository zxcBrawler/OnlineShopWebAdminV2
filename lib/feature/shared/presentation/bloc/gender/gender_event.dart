abstract class RemoteGenderEvent {
  final dynamic param;
  const RemoteGenderEvent({this.param});
}

class GetGenders extends RemoteGenderEvent {
  const GetGenders();
}
