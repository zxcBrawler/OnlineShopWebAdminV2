import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/generated/l10n.dart';

// Menu items for each role

List<Map<String, dynamic>> adminMenuItems(BuildContext context) {
  return [
    {
      'tabIcon': Icons.dashboard,
      'title': S.of(context).dashboard,
      'route': Pages.adminDashboard.screenPath
    },
    {
      'tabIcon': Icons.group,
      'title': S.of(context).users,
      'route': Pages.adminUsers.screenPath
    },
    {
      'tabIcon': Icons.checkroom,
      'title': S.of(context).clothesInfo,
      'route': Pages.adminClothes.screenPath
    },
    {
      'tabIcon': Icons.location_on,
      'title': S.of(context).shops,
      'route': Pages.adminShops.screenPath
    },
    {
      'tabIcon': Icons.assignment,
      'title': S.of(context).allOrders,
      'route': Pages.adminOrders.screenPath
    },
  ];
}

List<Map<String, dynamic>> directorMenuItems(BuildContext context) {
  return [
    {
      'tabIcon': Icons.dashboard,
      'title': S.of(context).dashboard,
      'route': Pages.directorDashboard.screenPath
    },
    {
      'tabIcon': Icons.group,
      'title': S.of(context).employees,
      'route': Pages.directorEmployees.screenPath
    },
    {
      'tabIcon': Icons.checkroom,
      'title': S.of(context).clothesInfo,
      'route': Pages.directorClothes.screenPath
    },
    {
      'tabIcon': Icons.location_on,
      'title': S.of(context).myShop,
      'route': Pages.directorShop.screenPath
    },
    {
      'tabIcon': Icons.assignment,
      'title': S.of(context).shopOrders,
      'route': Pages.directorOrders.screenPath
    },
  ];
}

List<Map<String, dynamic>> employeeMenuItems(BuildContext context) {
  return [
    {
      'tabIcon': Icons.dashboard,
      'title': S.of(context).dashboard,
      'route': Pages.employeeDashboard.screenPath
    },
    {
      'tabIcon': Icons.checkroom,
      'title': S.of(context).clothesInfo,
      'route': Pages.employeeClothes.screenPath
    },
    {
      'tabIcon': Icons.assignment,
      'title': S.of(context).shopOrders,
      'route': Pages.employeeOrders.screenPath
    },
  ];
}
