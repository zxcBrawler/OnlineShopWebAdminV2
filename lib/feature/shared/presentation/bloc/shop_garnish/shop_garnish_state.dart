import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_garnish_entity.dart';

abstract class RemoteShopGarnishState {
  final List<ShopGarnishEntity>? shopGarnish;
  final DioException? error;
  const RemoteShopGarnishState({this.shopGarnish, this.error});
}

class RemoteShopGarnishLoading extends RemoteShopGarnishState {
  const RemoteShopGarnishLoading();
}

class RemoteShopGarnishDone extends RemoteShopGarnishState {
  const RemoteShopGarnishDone(List<ShopGarnishEntity> shopGarnish)
      : super(shopGarnish: shopGarnish);
}

class RemoteShopGarnishError extends RemoteShopGarnishState {
  const RemoteShopGarnishError(DioException error) : super(error: error);
}
