import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_address_repo.dart';

class DeleteShopAddressUsecase implements UseCase<DataState<void>, int> {
  final ShopAddressRepo _mainRepo;

  DeleteShopAddressUsecase(this._mainRepo);

  @override
  Future<DataState<void>> call({int? params}) async {
    return await _mainRepo.deleteAddress(params!);
  }
}
