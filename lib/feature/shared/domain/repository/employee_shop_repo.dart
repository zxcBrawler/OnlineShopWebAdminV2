import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/employee_shop.dart';

abstract class EmployeeShopRepo {
  Future<DataState<EmployeeShopEntity>> getShopAddressByEmployeeId({int? id});

  Future<DataState<List<EmployeeShopEntity>>> getAllEmployeesFromShop(
      {int? id});
}
