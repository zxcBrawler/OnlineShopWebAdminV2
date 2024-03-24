abstract class RemoteAddressesEvent {
  final dynamic param;
  const RemoteAddressesEvent({this.param});
}

class GetAddresses extends RemoteAddressesEvent {
  final int? id;
  const GetAddresses({this.id});
}
