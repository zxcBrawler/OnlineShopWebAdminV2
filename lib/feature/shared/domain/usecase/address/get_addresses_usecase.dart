import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/address_repo.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';

class GetAddressesUsecase
    implements UseCase<DataState<List<AddressEntity>>, int> {
  final AddressRepo _mainRepo;

  GetAddressesUsecase(this._mainRepo);
  @override
  Future<DataState<List<AddressEntity>>> call({int? params}) async {
    return await _mainRepo.getAllAddresses();
  }
}
