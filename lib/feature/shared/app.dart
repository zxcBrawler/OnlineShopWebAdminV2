//implement app after routes

import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/custom_scroll.dart';
import 'package:xc_web_admin/config/themes.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
