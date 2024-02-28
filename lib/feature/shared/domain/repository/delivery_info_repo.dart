import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';

abstract class DeliveryInfoRepo {
  Future<DataState<List<DeliveryInfoEntity>>> getAllInfo();
}
