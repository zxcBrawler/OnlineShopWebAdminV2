import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_address_entity.dart';

abstract class AddressRepo {
  Future<DataState<List<AddressEntity>>> getAllAddresses();
  Future<DataState<List<UserAddressEntity>>> getAddressById({int? id});
}
