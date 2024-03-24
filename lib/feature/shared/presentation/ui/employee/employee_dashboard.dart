import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_clothes_weelky_items_sold_overview.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_weekly_orders_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/employee/employee_total_items.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  @override

  /// Builds the user interface widget tree.
  ///
  /// The method builds a scrollable widget tree that wraps its content
  /// with a [SafeArea] to avoid any overlap with system UI. It uses a
  /// [SingleChildScrollView] to enable vertical scrolling.
  ///
  /// The UI is built differently depending on whether the device is a
  /// desktop or not. For a desktop device, it displays a [Header] widget
  /// with a 'dashboard' title and a [Row] widget with no children. For a
  /// non-desktop device, it also displays a [Header] widget with a
  /// 'dashboard' title.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap the content with SafeArea to avoid any overlap with system UI
      child: SingleChildScrollView(
        // Wrap the content with SingleChildScrollView to enable vertical scrolling
        padding: const EdgeInsets.all(16.0),
        child: Responsive.isDesktop(context)
            ? BlocProvider<RemoteEmployeeShopBloc>(
                create: (context) => service()
                  ..add(GetShopAddressByEmployeeId(
                      employeeId:
                          int.parse(SessionStorage.getValue("employeeId")))),
                child: BlocBuilder<RemoteEmployeeShopBloc,
                    RemoteEmployeeShopState>(builder: (context, state) {
                  switch (state.runtimeType) {
                    case RemoteEmployeeShopLoading:
                      return const SizedBox();
                    case RemoteShopAddressByEmployeeIdDone:
                      SessionStorage.saveLocalData("shopAddressId",
                          state.shop!.shopAddresses!.shopAddressId!);
                      return const Column(
                        children: [
                          Header(
                            title: 'dashboard',
                          ),
                          EmployeeTotalItems(),
                          Row(
                            children: [
                              DirectorWeeklyItemsSold(),
                            ],
                          ),
                          DirectorWeeklyOrdersWidget(),
                        ],
                      );

                    case RemoteEmployeeShopError:
                      return Text(state.error.toString());
                  }
                  return const SizedBox();
                }))
            : BlocProvider<RemoteEmployeeShopBloc>(
                create: (context) => service()
                  ..add(GetShopAddressByEmployeeId(
                      employeeId:
                          int.parse(SessionStorage.getValue("employeeId")))),
                child: BlocBuilder<RemoteEmployeeShopBloc,
                    RemoteEmployeeShopState>(builder: (context, state) {
                  switch (state.runtimeType) {
                    case RemoteEmployeeShopLoading:
                      return const SizedBox();
                    case RemoteShopAddressByEmployeeIdDone:
                      SessionStorage.saveLocalData("shopAddressId",
                          state.shop!.shopAddresses!.shopAddressId!);
                      return const Column(
                        children: [
                          Header(
                            title: 'dashboard',
                          ),
                          EmployeeTotalItems(),
                          Row(
                            children: [
                              DirectorWeeklyItemsSold(),
                            ],
                          ),
                          DirectorWeeklyOrdersWidget(),
                        ],
                      );

                    case RemoteEmployeeShopError:
                      return Text(state.error.toString());
                  }
                  return const SizedBox();
                })),
      ),
    );
  }
}
