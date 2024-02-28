import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/order/get_orders_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';

class RemoteDeliveryInfoBloc
    extends Bloc<RemoteDeliveryInfoEvent, RemoteDeliveryInfoState> {
  final GetDeliveryInfoUsecase _getDeliveryInfoUsecase;

  RemoteDeliveryInfoBloc(this._getDeliveryInfoUsecase)
      : super(const RemoteDeliveryInfoLoading()) {
    on<GetDeliveryInfo>(onGetDeliveryInfo);
  }

  void onGetDeliveryInfo(
      GetDeliveryInfo event, Emitter<RemoteDeliveryInfoState> emit) async {
    final dataState = await _getDeliveryInfoUsecase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      print(dataState.data);
      emit(RemoteDeliveryInfoDone(dataState.data!));
    }
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      emit(RemoteDeliveryInfoError(dataState.error!));
    }
    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteDeliveryInfoError(dataState.error!));
    }
  }
}
