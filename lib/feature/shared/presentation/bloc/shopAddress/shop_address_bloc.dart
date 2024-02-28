import 'package:bloc/bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shopAddress/delete_shop_address_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shopAddress/get_shop_addresses_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_state.dart';

class RemoteShopAddressesBloc
    extends Bloc<RemoteShopAddressesEvent, RemoteShopAddressState> {
  final GetShopAddressesUsecase _getShopAddressesUsecase;
  final DeleteShopAddressUsecase _deleteShopAddressUsecase;
  RemoteShopAddressesBloc(
    this._getShopAddressesUsecase,
    this._deleteShopAddressUsecase,
  ) : super(const RemoteShopAddressLoading()) {
    on<GetShopAddresses>(onGetShopAddresses);
    on<DeleteShopAddress>(onDeleteShopAddresses);
  }

  void onGetShopAddresses(
      GetShopAddresses event, Emitter<RemoteShopAddressState> emitter) async {
    final dataState = await _getShopAddressesUsecase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);
      emitter(RemoteShopAddressDone(dataState.data!));
    }
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emitter(RemoteShopAddressError(dataState.error!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emitter(RemoteShopAddressError(dataState.error!));
    }
  }

  void onDeleteShopAddresses(
      DeleteShopAddress event, Emitter<RemoteShopAddressState> emitter) async {
    final dataState = await _deleteShopAddressUsecase(params: event.id);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);
      emitter(RemoteShopAddressDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emitter(RemoteShopAddressError(dataState.error!));
    }
  }
}
