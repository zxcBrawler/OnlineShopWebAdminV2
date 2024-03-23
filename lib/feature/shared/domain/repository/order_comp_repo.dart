import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';

abstract class OrderCompRepo {
  Future<DataState<List<OrderCompositionEntity>>> getOrderComposition();
}
