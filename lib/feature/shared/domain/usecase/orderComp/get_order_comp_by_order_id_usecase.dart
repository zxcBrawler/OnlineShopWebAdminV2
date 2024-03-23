import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/order_comp_repo.dart';

class GetOrderCompByOrderIdUsecase
    implements UseCase<DataState<List<OrderCompositionEntity>>, int> {
  final OrderCompRepo _orderCompRepo;

  GetOrderCompByOrderIdUsecase(this._orderCompRepo);
  @override
  Future<DataState<List<OrderCompositionEntity>>> call({int? params}) async {
    return await _orderCompRepo.getOrderCompositionByOrderId(id: params);
  }
}
