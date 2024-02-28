abstract class RemoteDeliveryInfoEvent {
  final dynamic param;
  const RemoteDeliveryInfoEvent({this.param});
}

class GetDeliveryInfo extends RemoteDeliveryInfoEvent {
  const GetDeliveryInfo();
}
