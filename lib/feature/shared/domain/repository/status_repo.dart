import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/dto/edit_status_dto.dart';
import 'package:xc_web_admin/feature/shared/data/model/status_order.dart';

abstract class StatusRepo {
  Future<DataState<List<StatusOrderModel>>> getStatuses();
  Future<DataState<void>> updateStatus({StatusDTO? statusDTO});
}
