import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_clothes_weelky_items_sold_overview.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_weekly_orders_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/employee/employee_total_items.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  @override

  /// Builds the widget tree for the [EmployeeDashboard].
  ///
  /// This method wraps the content with [SafeArea] to avoid any overlap with
  /// system UI. It also wraps the content with [SingleChildScrollView] to enable
  /// vertical scrolling.
  ///
  /// The method uses [BlocProvider] to provide an instance of
  /// [RemoteEmployeeShopBloc] to its child. It creates a new instance of the
  /// bloc and adds a [GetShopAddressByEmployeeId] event to it, passing the
  /// employee id stored in [SessionStorage].
  ///
  /// The method uses [BlocBuilder] to rebuild the UI whenever the state of the
  /// [RemoteEmployeeShopBloc] changes. It renders different widgets based on
  /// the runtime type of the state.
  ///
  /// Returns the built widget tree.
  Widget build(BuildContext context) {
    // Wrap the content with SafeArea to avoid any overlap with system UI
    return SafeArea(
      child: SingleChildScrollView(
        // Wrap the content with SingleChildScrollView to enable vertical scrolling
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider<RemoteEmployeeShopBloc>(
            // Use BlocProvider to provide an instance of RemoteEmployeeShopBloc
            create: (context) => service()
              ..add(GetShopAddressByEmployeeId(
                  employeeId:
                      int.parse(SessionStorage.getValue("employeeId")))),
            // Use BlocBuilder to rebuild the UI whenever the state changes
            child: BlocBuilder<RemoteEmployeeShopBloc, RemoteEmployeeShopState>(
                builder: (context, state) {
              // Render different widgets based on the state type
              switch (state.runtimeType) {
                case RemoteEmployeeShopLoading:
                  // Render nothing if the state is still loading
                  return const SizedBox();
                case RemoteShopAddressByEmployeeIdDone:
                  // Save the shop address id to SessionStorage
                  SessionStorage.saveLocalData("shopAddressId",
                      state.shop!.shopAddresses!.shopAddressId!);
                  // Render the main widgets
                  return Column(
                    children: [
                      Header(
                        title: S.current.dashboard,
                      ),
                      const EmployeeTotalItems(),
                      const Row(
                        children: [
                          DirectorWeeklyItemsSold(),
                        ],
                      ),
                      const DirectorWeeklyOrdersWidget(),
                    ],
                  );

                case RemoteEmployeeShopError:
                  // Render the error message if there's an error
                  return Text(state.error.toString());
              }
              // Render nothing if the state is of an unknown type
              return const SizedBox();
            })),
      ),
    );
  }
}
