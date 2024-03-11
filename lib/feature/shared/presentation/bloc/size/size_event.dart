abstract class RemoteSizeEvent {
  final dynamic param;
  const RemoteSizeEvent({this.param});
}

class GetSizes extends RemoteSizeEvent {
  const GetSizes();
}
