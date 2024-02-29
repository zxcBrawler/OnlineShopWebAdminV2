import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xc_web_admin/core/widget/widget/custom_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_active_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_clothes.dart.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_dashboard.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_drawer.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_orders_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_shops_main.dart';

import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_users_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_weekly_activity_details.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/resources/controller/side_menu_controller.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      key: context.read<SideMenuController>().scaffoldKey,
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isDesktop(context))
            const Expanded(
              child: AdminDrawer(),
            ),
          Expanded(
            flex: 5,
            child: widget.child!,
          ),
        ],
      )),
    );
  }

  void goOtherTab(BuildContext context, int index) {
    if (index == _currentPage) return;
    GoRouter router = GoRouter.of(context);
    String location = adminPages[index].initialLocation;

    setState(() {
      _currentPage = index;
    });
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
