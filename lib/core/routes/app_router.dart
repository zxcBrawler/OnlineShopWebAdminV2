import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_active_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_clothes.dart.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_orders.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_dashboard.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_main_screen.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_orders_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_shop_address_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_shops_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_user_addresses.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_user_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_users_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_weekly_activity_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/auth/auth_page.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router =
    GoRouter(initialLocation: '/', navigatorKey: _rootNavigatorKey, routes: [
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: Pages.auth.screenPath,
    name: Pages.auth.screenName,
    builder: (context, state) {
      return const AuthPage();
    },
  ),
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: Pages.adminUserInfo.screenPath,
    name: Pages.adminUserInfo.screenName,
    builder: (context, state) {
      Set<UserEntity> user = state.extra as Set<UserEntity>;
      return AdminUserDetails(
        user: user.first,
      );
    },
  ),
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: Pages.adminShopAddressInfo.screenPath,
    name: Pages.adminShopAddressInfo.screenName,
    builder: (context, state) {
      HashSet<ShopAddressModel> address =
          state.extra as HashSet<ShopAddressModel>;
      return AdminShopAddressInfo(
        shopAddressModel: address.first,
      );
    },
  ),
  ShellRoute(
    parentNavigatorKey: _rootNavigatorKey,
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) {
      return AdminMainScreen(
        location: state.matchedLocation,
        child: child,
      );
    },
    routes: [
      GoRoute(
        path: Pages.adminDashboard.screenPath,
        name: Pages.adminDashboard.screenName,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminDashboard());
        },
      ),
      GoRoute(
        path: Pages.adminUsers.screenPath,
        name: Pages.adminUsers.screenName,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminUsers());
        },
      ),
      GoRoute(
        path: Pages.adminClothes.screenPath,
        name: Pages.adminClothes.screenName,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminClothes());
        },
      ),
      GoRoute(
        path: Pages.adminShops.screenPath,
        name: Pages.adminShops.screenName,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminShops());
        },
      ),
      GoRoute(
        path: Pages.adminOrders.screenPath,
        name: Pages.adminOrders.screenName,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminOrders());
        },
      ),
      GoRoute(
        path: Pages.adminAllUsers.screenPath,
        name: Pages.adminAllUsers.screenName,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminAllUsers());
        },
      ),
      GoRoute(
        path: Pages.adminAllActiveUsers.screenPath,
        name: Pages.adminAllActiveUsers.screenName,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AllActiveUsers());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminWeeklyActivityDetails.screenPath,
        name: Pages.adminWeeklyActivityDetails.screenName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: WeeklyActivityDetails());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminUserAddresses.screenPath,
        name: Pages.adminUserAddresses.screenName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminUserAddresses());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminAllOrders.screenPath,
        name: Pages.adminAllOrders.screenName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminAllOrders());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminAllClothes.screenPath,
        name: Pages.adminAllClothes.screenName,
        pageBuilder: (context, state) {
          HashSet<String> title = state.extra as HashSet<String>;
          return NoTransitionPage(
              child: AdminAllClothes(
            title: title.first,
          ));
        },
      ),
    ],
  ),
]);
