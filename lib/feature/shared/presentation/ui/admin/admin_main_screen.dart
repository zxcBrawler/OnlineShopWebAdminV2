import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xc_web_admin/core/resources/controller/side_menu_controller.dart';
import 'package:xc_web_admin/core/widget/widget/custom_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_active_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_clothes.dart.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_dashboard.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_orders_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_shops_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_users_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_weekly_activity_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_drawer.dart';

import '../../../../../core/routes/router_utils.dart';

class AdminMainScreen extends StatefulWidget {
  final String? location;
  final Widget? child;
  const AdminMainScreen({super.key, this.location, this.child});

  @override
  State<AdminMainScreen> createState() => AdminMainScreenState();
}

class AdminMainScreenState extends State<AdminMainScreen> {
  int _currentPage = 0;

  @override

  /// The main screen widget for the admin panel.
  ///
  /// This widget builds a Scaffold that includes a drawer and a body. The
  /// body is a SafeArea that contains a Row with a single child: [widget.child].
  ///
  /// The [widget.child] is the child widget that is displayed in the body.
  /// The [widget.child] is passed to the widget when it is created.
  ///
  /// The scaffold also has a key that is obtained from the [SideMenuController].
  Widget build(BuildContext context) {
    return Scaffold(
      // The drawer for the admin panel.
      drawer: const AdminDrawer(),
      // The key for the Scaffold. The key is obtained from the SideMenuController.
      key: context.read<SideMenuController>().scaffoldKey,
      // The body of the Scaffold.
      body: SafeArea(
        // The child widget that is displayed in the body.
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The child widget that is passed to the widget when it is created.
            Expanded(
              flex: 6,
              child: widget.child!,
            ),
          ],
        ),
      ),
    );
  }

  /// Navigates to a different tab in the admin panel.
  ///
  /// This function takes a [BuildContext] and an [index] as parameters.
  /// It changes the current page to the tab specified by [index] and navigates to the corresponding location.
  ///
  /// The function first checks if the current page is already the specified tab. If it is, the function returns.
  /// Otherwise, it updates the current page to the specified tab and navigates to the corresponding location using the GoRouter.
  void goOtherTab(BuildContext context, int index) {
    // Check if the current page is already the specified tab.
    if (index == _currentPage) return;

    // Get the GoRouter from the context.
    GoRouter router = GoRouter.of(context);

    // Get the initial location of the specified tab.
    String location = adminPages[index].initialLocation;

    // Update the current page to the specified tab.
    setState(() {
      _currentPage = index;
    });

    // Navigate to the specified location.
    router.go(location);
  }
}

final List<CustomWidget> adminPages = [
  CustomWidget(
      initialLocation: Pages.adminDashboard.screenPath,
      child: const AdminDashboard()),
  CustomWidget(
      initialLocation: Pages.adminUsers.screenPath, child: const AdminUsers()),
  CustomWidget(
      initialLocation: Pages.adminClothes.screenPath,
      child: const AdminClothes()),
  CustomWidget(
      initialLocation: Pages.adminShops.screenPath, child: const AdminShops()),
  CustomWidget(
      initialLocation: Pages.adminOrders.screenPath,
      child: const AdminOrders()),
  CustomWidget(
      initialLocation: Pages.adminAllActiveUsers.screenPath,
      child: const AllActiveUsers()),
  CustomWidget(
      initialLocation: Pages.adminWeeklyActivityDetails.screenPath,
      child: const WeeklyActivityDetails()),
  CustomWidget(
      initialLocation: Pages.adminAllUsers.screenPath,
      child: const AdminAllUsers()),
  CustomWidget(
      initialLocation: Pages.adminAllOrders.screenPath,
      child: const AdminAllUsers()),
  CustomWidget(
      initialLocation: Pages.adminAllClothes.screenPath,
      child: const AdminAllClothes()),
];
