import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/employee_shop.dart';

abstract class RemoteEmployeeShopState {
  final List<EmployeeShopEntity>? users;
  final EmployeeShopEntity? shop;
  final DioException? error;
  const RemoteEmployeeShopState({this.users, this.error, this.shop});
}

class RemoteEmployeeShopLoading extends RemoteEmployeeShopState {
  const RemoteEmployeeShopLoading();
}

class RemoteShopAddressByEmployeeIdDone extends RemoteEmployeeShopState {
  const RemoteShopAddressByEmployeeIdDone(EmployeeShopEntity employeeShopEntity)
      : super(shop: employeeShopEntity);
}

class RemoteAllEmployeesByShopIdDone extends RemoteEmployeeShopState {
  const RemoteAllEmployeesByShopIdDone(
      List<EmployeeShopEntity> employeeShopEntities)
      : super(users: employeeShopEntities);
}

class RemoteEmployeeShopError extends RemoteEmployeeShopState {
  const RemoteEmployeeShopError(DioException error) : super(error: error);
}
