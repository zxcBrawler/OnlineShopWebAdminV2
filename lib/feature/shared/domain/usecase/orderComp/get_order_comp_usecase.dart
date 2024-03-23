import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/order_comp_repo.dart';

class GetOrderCompUsecase
    implements UseCase<DataState<List<OrderCompositionEntity>>, void> {
  final OrderCompRepo _orderCompRepo;

  GetOrderCompUsecase(this._orderCompRepo);
  @override
  Future<DataState<List<OrderCompositionEntity>>> call({void params}) async {
    return await _orderCompRepo.getOrderComposition();
  }
}
