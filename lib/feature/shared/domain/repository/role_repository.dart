import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/model/role.dart';

abstract class RoleRepo {
  Future<DataState<List<RoleModel>>> getRoles();
}
