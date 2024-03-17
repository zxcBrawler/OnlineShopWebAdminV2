import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_garnish_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_garnish_entity.dart';

abstract class ShopGarnishRepo {
  Future<DataState<List<ShopGarnishEntity>>> getShopGarnish({int? id});
  Future<DataState<void>> updateQuantity({ShopGarnishDTO? shopGarnishDTO});
}
