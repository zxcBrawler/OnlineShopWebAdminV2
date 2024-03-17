import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_state.dart';

class DirectorDashboard extends StatefulWidget {
  const DirectorDashboard({super.key});

  @override
  State<DirectorDashboard> createState() => _DirectorDashboardState();
}

class _DirectorDashboardState extends State<DirectorDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override

  /// Builds the user interface for the director dashboard.
  ///
  /// This function returns a [SafeArea] widget that wraps a
  /// [SingleChildScrollView]. The [SingleChildScrollView] has padding
  /// of 16.0 and contains a [Column] widget. The [Column] contains a
  /// [Header] widget with the title 'dashboard'. Depending on the
  /// device, it either displays an empty [Row] or nothing at all.
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap the content with SafeArea to avoid any overlap with system UI
      child: SingleChildScrollView(
        // Wrap the content with SingleChildScrollView to enable vertical scrolling
        padding: const EdgeInsets.all(16.0),
        child: Responsive.isDesktop(context)
            ? Column(
                // Build the UI for a desktop device
                children: [
                  // Display the header
                  const Header(
                    title: 'dashboard',
                  ),
                  // Display an empty row for desktop devices
                  Row(
                    children: [
                      BlocProvider<RemoteEmployeeShopBloc>(
                          create: (context) => service()
                            ..add(GetShopAddressByEmployeeId(
                                employeeId: int.parse(
                                    SessionStorage.getValue("employeeId")))),
                          child: BlocBuilder<RemoteEmployeeShopBloc,
                                  RemoteEmployeeShopState>(
                              builder: (context, state) {
                            switch (state.runtimeType) {
                              case RemoteEmployeeShopLoading:
                                return const SizedBox();
                              case RemoteShopAddressByEmployeeIdDone:
                                SessionStorage.saveLocalData("shopAddressId",
                                    state.shop!.shopAddresses!.shopAddressId!);
                                return const SizedBox();

                              case RemoteEmployeeShopError:
                                return Text(state.error.toString());
                            }
                            return const SizedBox();
                          })),
                    ],
                  ),
                ],
              )
            : const Column(
                // Build the UI for a non-desktop device
                children: [
                  // Display the header
                  Header(
                    title: 'dashboard',
                  ),
                  // Don't display anything for non-desktop devices
                ],
              ),
      ),
    );
  }
}
