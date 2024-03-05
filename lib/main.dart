import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xc_web_admin/feature/shared/app.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/core/resources/controller/side_menu_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SideMenuController()),
      ],
      child: const MainApp(),
    ),
  );
}
