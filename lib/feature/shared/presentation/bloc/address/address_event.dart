abstract class RemoteAddressesEvent {
  final dynamic param;
  const RemoteAddressesEvent({this.param});

  List<Object> get props => [param!];
}

class GetAddresses extends RemoteAddressesEvent {
  const GetAddresses();
}
