abstract class RemoteShopAddressesEvent {
  final dynamic param;
  const RemoteShopAddressesEvent({this.param});

  List<Object> get props => [param!];
}

class GetShopAddresses extends RemoteShopAddressesEvent {
  const GetShopAddresses();
}

class DeleteShopAddress extends RemoteShopAddressesEvent {
  final int? id;
  const DeleteShopAddress(this.id);
}
