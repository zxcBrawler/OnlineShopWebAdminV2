abstract class RemoteOrderCompEvent {
  final dynamic param;
  const RemoteOrderCompEvent({this.param});
}

class GetOrderComp extends RemoteOrderCompEvent {
  const GetOrderComp();
}
