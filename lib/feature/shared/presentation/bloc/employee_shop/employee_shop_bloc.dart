import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/employee_shop/get_all_employees_by_shop_id_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/employee_shop/get_shop_address_by_employee_id_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_state.dart';

class RemoteEmployeeShopBloc
    extends Bloc<RemoteEmployeeShopEvent, RemoteEmployeeShopState> {
  final GetAllEmployeesByShopIdUsecase _getAllEmployeesByShopIdUsecase;
  final GetShopAddressByEmployeeIdUsecase _getShopAddressByEmployeeIdUsecase;

  RemoteEmployeeShopBloc(this._getAllEmployeesByShopIdUsecase,
      this._getShopAddressByEmployeeIdUsecase)
      : super(const RemoteEmployeeShopLoading()) {
    on<GetAllEmployeesByShopId>(onGetEmployees);
    on<GetShopAddressByEmployeeId>(onGetShopAddress);
  }

  /// Handles the [GetAllEmployeesByShopId] event.
  ///
  /// This method emits the appropriate [RemoteEmployeeShopState] based on the
  /// result of the retrieval of employees.
  ///
  /// If the retrieval is successful, it emits a [RemoteAllEmployeesByShopIdDone]
  /// state with the retrieved employees.
  /// If the retrieval is unsuccessful, it emits a [RemoteEmployeeShopError]
  /// state with the error message.
  ///
  /// The [event] parameter contains the `GetAllEmployeesByShopId` event.
  /// The [emit] parameter is a function used to emit states.
  ///
  /// Parameters:
  ///   - [event]: The `GetAllEmployeesByShopId` event containing the necessary
  ///     data.
  ///   - [emit]: The function used to emit states.
  void onGetEmployees(GetAllEmployeesByShopId event,
      Emitter<RemoteEmployeeShopState> emit) async {
    // Call the use case to get employees.
    final dataState =
        await _getAllEmployeesByShopIdUsecase(params: event.shopId);

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteAllEmployeesByShopIdDone state.
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      // Emit the RemoteAllEmployeesByShopIdDone state with the retrieved data.
      emit(RemoteAllEmployeesByShopIdDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data, emit a
    // RemoteEmployeeShopError state.
    if (dataState is DataSuccess && dataState.data!.isEmpty) {
      // Emit the RemoteEmployeeShopError state with the error message.
      emit(RemoteEmployeeShopError(dataState.error!));
    }
  }

  /// Handles the [GetShopAddressByEmployeeId] event.
  ///
  /// This method emits the appropriate [RemoteEmployeeShopState] based on the
  /// result of the retrieval of shop address.
  ///
  /// If the retrieval is successful, it emits a [RemoteShopAddressByEmployeeIdDone]
  /// state with the retrieved shop address.
  /// If the retrieval is unsuccessful, it emits a [RemoteEmployeeShopError]
  /// state with the error message.
  ///
  /// The [event] parameter contains the `GetShopAddressByEmployeeId` event.
  /// The [emit] parameter is a function used to emit states.
  ///
  /// Parameters:
  ///   - [event]: The `GetShopAddressByEmployeeId` event containing the necessary
  ///     data.
  ///   - [emit]: The function used to emit states.
  void onGetShopAddress(GetShopAddressByEmployeeId event,
      Emitter<RemoteEmployeeShopState> emit) async {
    // Call the use case to get shop address.
    final dataState =
        await _getShopAddressByEmployeeIdUsecase(params: event.employeeId);

    // If the use case returns a DataSuccess with non-empty data,
    // emit a RemoteShopAddressByEmployeeIdDone state.
    if (dataState is DataSuccess) {
      // Emit the RemoteShopAddressByEmployeeIdDone state with the retrieved data.
      emit(RemoteShopAddressByEmployeeIdDone(dataState.data!));
    }

    // If the use case returns a DataSuccess with empty data, emit a
    // RemoteEmployeeShopError state.
    if (dataState is DataFailed) {
      // Emit the RemoteEmployeeShopError state with the error message.
      emit(RemoteEmployeeShopError(dataState.error!));
    }
  }
}
