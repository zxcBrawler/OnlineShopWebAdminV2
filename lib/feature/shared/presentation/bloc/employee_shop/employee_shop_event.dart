abstract class RemoteEmployeeShopEvent {
  final dynamic param;
  const RemoteEmployeeShopEvent({this.param});
}

class GetAllEmployeesByShopId extends RemoteEmployeeShopEvent {
  final int shopId;
  const GetAllEmployeesByShopId({required this.shopId});
}

class GetShopAddressByEmployeeId extends RemoteEmployeeShopEvent {
  final int employeeId;
  const GetShopAddressByEmployeeId({required this.employeeId});
}
