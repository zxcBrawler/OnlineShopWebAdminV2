import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';

List<Map<String, dynamic>> adminMenuItems = [
  {
    'tabIcon': Icons.dashboard,
    'title': 'dashboard',
    'route': Pages.adminDashboard.screenPath
  },
  {
    'tabIcon': Icons.group,
    'title': 'users',
    'route': Pages.adminUsers.screenPath
  },
  {
    'tabIcon': Icons.checkroom,
    'title': 'clothes',
    'route': Pages.adminClothes.screenPath
  },
  {
    'tabIcon': Icons.location_on,
    'title': 'shops',
    'route': Pages.adminShops.screenPath
  },
  {
    'tabIcon': Icons.assignment,
    'title': 'orders',
    'route': Pages.adminOrders.screenPath
  },
];
