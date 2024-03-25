import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:xc_web_admin/core/resources/controller/side_menu_controller.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'tokens.env');
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
