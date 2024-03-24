import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/address_repo.dart';

class GetAddressesUsecase
    implements UseCase<DataState<List<UserAddressEntity>>, int> {
  final AddressRepo _mainRepo;

  GetAddressesUsecase(this._mainRepo);
  @override
  Future<DataState<List<UserAddressEntity>>> call({int? params}) async {
    return await _mainRepo.getAddressById(id: params);
  }
}
