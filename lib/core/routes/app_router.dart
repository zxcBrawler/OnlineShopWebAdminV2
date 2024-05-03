import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/feature/shared/data/model/clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_garnish.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_active_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_colors.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_female_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_male_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_orders.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_sizes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_all_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_clothes_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_dashboard.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_main_screen.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_weekly_items_sold_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_weekly_orders_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_all_female_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_all_male_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_weekly_items_sold_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_weekly_orders_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_all_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_all_female_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_all_male_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_all_orders.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_clothes_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_orders.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_weekly_orders_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/shared/order_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_orders_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_shop_address_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_shops_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_user_addresses.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_user_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/admin/admin_users_main.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/auth/mobile_auth_page.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_all_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_all_orders.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_clothes_details.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_dashboard.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_employees.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_main_screen.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_shop_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/director/director_shop_orders.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_dashboard.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/employee/employee_main_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// Go router routes to different screens
final router =
    GoRouter(initialLocation: '/', navigatorKey: _rootNavigatorKey, routes: [
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: Pages.auth.screenPath,
    name: Pages.auth.screenName,
    builder: (context, state) {
      return const MobileAuthPage();
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
    path: Pages.adminOrderDetails.screenPath,
    name: Pages.adminOrderDetails.screenName,
    builder: (context, state) {
      Set<DeliveryInfoEntity> deliveryInfo =
          state.extra as Set<DeliveryInfoEntity>;
      return OrderDetails(
        deliveryInfo: deliveryInfo.first,
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
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: Pages.adminClothesDetails.screenPath,
    name: Pages.adminClothesDetails.screenName,
    builder: (context, state) {
      HashSet<ClothesModel> clothes = state.extra as HashSet<ClothesModel>;
      return AdminClothesDetails(
        clothes: clothes.first,
      );
    },
  ),
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: Pages.directorClothesDetails.screenPath,
    name: Pages.directorClothesDetails.screenName,
    builder: (context, state) {
      HashSet<ShopGarnishModel> clothes =
          state.extra as HashSet<ShopGarnishModel>;
      return DirectorClothesDetails(
        clothes: clothes.first,
      );
    },
  ),
  GoRoute(
    parentNavigatorKey: _rootNavigatorKey,
    path: Pages.employeeClothesDetails.screenPath,
    name: Pages.employeeClothesDetails.screenName,
    builder: (context, state) {
      HashSet<ShopGarnishModel> clothes =
          state.extra as HashSet<ShopGarnishModel>;
      return EmployeeClothesDetails(
        clothes: clothes.first,
      );
    },
  ),
  ShellRoute(
      parentNavigatorKey: _rootNavigatorKey,
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return DirectorMainScreen(
          location: state.matchedLocation,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: Pages.directorDashboard.screenPath,
          name: Pages.directorDashboard.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorDashboard());
          },
        ),
        GoRoute(
          path: Pages.directorEmployees.screenPath,
          name: Pages.directorEmployees.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorEmployees());
          },
        ),
        GoRoute(
          path: Pages.directorClothes.screenPath,
          name: Pages.directorClothes.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorClothes());
          },
        ),
        GoRoute(
          path: Pages.directorShop.screenPath,
          name: Pages.directorShop.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorShopInfo());
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Pages.directorAllClothes.screenPath,
          name: Pages.directorAllClothes.screenName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorAllClothes());
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Pages.directorAllFemaleClothes.screenPath,
          name: Pages.directorAllFemaleClothes.screenName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorAllFemaleClothes());
          },
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Pages.directorAllMaleClothes.screenPath,
          name: Pages.directorAllMaleClothes.screenName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorAllMaleClothes());
          },
        ),
        GoRoute(
          path: Pages.directorOrders.screenPath,
          name: Pages.directorOrders.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorShopOrders());
          },
        ),
        GoRoute(
          path: Pages.directorAllOrders.screenPath,
          name: Pages.directorAllOrders.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorAllOrders());
          },
        ),
        GoRoute(
          path: Pages.directorWeeklyItemsSoldDetails.screenPath,
          name: Pages.directorWeeklyItemsSoldDetails.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
                child: DirectorWeeklyItemsSoldDetails());
          },
        ),
        GoRoute(
          path: Pages.directorWeeklyOrdersDetails.screenPath,
          name: Pages.directorWeeklyOrdersDetails.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: DirectorWeeklyOrdersDetails());
          },
        ),
      ]),
  ShellRoute(
      parentNavigatorKey: _rootNavigatorKey,
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return EmployeeMainScreen(
          location: state.matchedLocation,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: Pages.employeeDashboard.screenPath,
          name: Pages.employeeDashboard.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: EmployeeDashboard());
          },
        ),
        GoRoute(
          path: Pages.employeeClothes.screenPath,
          name: Pages.employeeClothes.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: EmployeeClothes());
          },
        ),
        GoRoute(
          path: Pages.employeeOrders.screenPath,
          name: Pages.employeeOrders.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: EmployeeShopOrders());
          },
        ),
        GoRoute(
          path: Pages.employeeAllClothes.screenPath,
          name: Pages.employeeAllClothes.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: EmployeeAllClothes());
          },
        ),
        GoRoute(
          path: Pages.employeeAllFemaleClothes.screenPath,
          name: Pages.employeeAllFemaleClothes.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: EmployeeAllFemaleClothes());
          },
        ),
        GoRoute(
          path: Pages.employeeAllMaleClothes.screenPath,
          name: Pages.employeeAllMaleClothes.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: EmployeeAllMaleClothes());
          },
        ),
        GoRoute(
          path: Pages.employeeAllOrders.screenPath,
          name: Pages.employeeAllOrders.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: EmployeeAllOrders());
          },
        ),
        GoRoute(
          path: Pages.employeeWeeklyOrdersDetails.screenPath,
          name: Pages.employeeWeeklyOrdersDetails.screenName,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: EmployeeWeeklyOrdersDetails());
          },
        ),
      ]),
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
          return const NoTransitionPage(child: AdminAllClothes());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminAllFemaleClothes.screenPath,
        name: Pages.adminAllFemaleClothes.screenName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminAllFemaleClothes());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminAllMaleClothes.screenPath,
        name: Pages.adminAllMaleClothes.screenName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminAllMaleClothes());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminAllColors.screenPath,
        name: Pages.adminAllColors.screenName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminAllColors());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminAllSizes.screenPath,
        name: Pages.adminAllSizes.screenName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminAllSizes());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminWeeklyItemsSoldDetails.screenPath,
        name: Pages.adminWeeklyItemsSoldDetails.screenName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminWeeklyItemsSoldDetails());
        },
      ),
      GoRoute(
        parentNavigatorKey: _shellNavigatorKey,
        path: Pages.adminWeeklyOrdersDetails.screenPath,
        name: Pages.adminWeeklyOrdersDetails.screenName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AdminWeeklyOrdersDetails());
        },
      ),
    ],
  ),
]);
