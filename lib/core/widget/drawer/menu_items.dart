import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/generated/l10n.dart';

// Menu items for each role
List<Map<String, dynamic>> adminMenuItems = [
  {
    'tabIcon': Icons.dashboard,
    'title': S.current.dashboard,
    'route': Pages.adminDashboard.screenPath
  },
  {
    'tabIcon': Icons.group,
    'title': S.current.users,
    'route': Pages.adminUsers.screenPath
  },
  {
    'tabIcon': Icons.checkroom,
    'title': S.current.clothesInfo,
    'route': Pages.adminClothes.screenPath
  },
  {
    'tabIcon': Icons.location_on,
    'title': S.current.shops,
    'route': Pages.adminShops.screenPath
  },
  {
    'tabIcon': Icons.assignment,
    'title': S.current.allOrders,
    'route': Pages.adminOrders.screenPath
  },
];

List<Map<String, dynamic>> directorMenuItems = [
  {
    'tabIcon': Icons.dashboard,
    'title': S.current.dashboard,
    'route': Pages.directorDashboard.screenPath
  },
  {
    'tabIcon': Icons.group,
    'title': S.current.employees,
    'route': Pages.directorEmployees.screenPath
  },
  {
    'tabIcon': Icons.checkroom,
    'title': S.current.clothesInfo,
    'route': Pages.directorClothes.screenPath
  },
  {
    'tabIcon': Icons.location_on,
    'title': S.current.myShop,
    'route': Pages.directorShop.screenPath
  },
  {
    'tabIcon': Icons.assignment,
    'title': S.current.shopOrders,
    'route': Pages.directorOrders.screenPath
  },
];

List<Map<String, dynamic>> employeeMenuItems = [
  {
    'tabIcon': Icons.dashboard,
    'title': S.current.dashboard,
    'route': Pages.employeeDashboard.screenPath
  },
  {
    'tabIcon': Icons.checkroom,
    'title': S.current.clothesInfo,
    'route': Pages.employeeClothes.screenPath
  },
  {
    'tabIcon': Icons.assignment,
    'title': S.current.shopOrders,
    'route': Pages.employeeOrders.screenPath
  },
];
