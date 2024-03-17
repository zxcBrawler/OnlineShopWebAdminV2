import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/employee_shop.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/employee_shop_repo.dart';

class GetShopAddressByEmployeeIdUsecase
    implements UseCase<DataState<EmployeeShopEntity>, int> {
  final EmployeeShopRepo _employeeShopRepo;

  GetShopAddressByEmployeeIdUsecase(this._employeeShopRepo);

  @override
  Future<DataState<EmployeeShopEntity>> call({int? params}) async {
    return await _employeeShopRepo.getShopAddressByEmployeeId(id: params);
  }
}
