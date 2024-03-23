abstract class RemoteOrderCompEvent {
  final dynamic param;
  const RemoteOrderCompEvent({this.param});
}

class GetOrderComp extends RemoteOrderCompEvent {
  const GetOrderComp();
}

class GetOrderCompByOrderId extends RemoteOrderCompEvent {
  final int id;
  const GetOrderCompByOrderId({required this.id});
}
