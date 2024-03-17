import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/employee_shop.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/employee_shop_repo.dart';

class GetAllEmployeesByShopIdUsecase
    implements UseCase<DataState<List<EmployeeShopEntity>>, int> {
  final EmployeeShopRepo _employeeShopRepo;

  GetAllEmployeesByShopIdUsecase(this._employeeShopRepo);

  @override
  Future<DataState<List<EmployeeShopEntity>>> call({int? params}) async {
    return await _employeeShopRepo.getAllEmployeesFromShop(id: params);
  }
}
