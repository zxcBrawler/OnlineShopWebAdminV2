abstract class RemoteColorEvent {
  final dynamic param;
  const RemoteColorEvent({this.param});
}

class GetColors extends RemoteColorEvent {
  const GetColors();
}
