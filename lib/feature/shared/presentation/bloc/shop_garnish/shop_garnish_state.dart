import 'package:dio/dio.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_garnish_entity.dart';

abstract class RemoteShopGarnishState {
  final List<ShopGarnishEntity>? shopGarnish;
  final ShopGarnishEntity? addedShopGarnish;
  final DioException? error;
  const RemoteShopGarnishState(
      {this.shopGarnish, this.error, this.addedShopGarnish});
}

class RemoteShopGarnishLoading extends RemoteShopGarnishState {
  const RemoteShopGarnishLoading();
}

class RemoteShopGarnishDone extends RemoteShopGarnishState {
  const RemoteShopGarnishDone(List<ShopGarnishEntity> shopGarnish)
      : super(shopGarnish: shopGarnish);
}

class RemoteAddShopGarnishDone extends RemoteShopGarnishState {
  const RemoteAddShopGarnishDone(ShopGarnishEntity addedShopGarnish)
      : super(addedShopGarnish: addedShopGarnish);
}

class RemoteDeleteShopGarnishDone extends RemoteShopGarnishState {
  const RemoteDeleteShopGarnishDone();
}

class RemoteShopGarnishError extends RemoteShopGarnishState {
  const RemoteShopGarnishError(DioException error) : super(error: error);
}
