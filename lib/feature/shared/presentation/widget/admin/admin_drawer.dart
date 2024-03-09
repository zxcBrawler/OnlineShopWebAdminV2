import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/constants/shared_prefs.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/sidemenu/side_menu_tab.dart';

import '../../../../../core/constants/menu_items.dart';

/// Widget representing the admin drawer
class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.darkBrown,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
                child: Image.asset("assets/xc-logo-transparent-white.png")),

            /// Admin menu tabs generator with SideMenuTab widget
            /// for each menu item in [adminMenuItems] list stored in [../constants/menu_items.dart]
            for (var item in adminMenuItems)
              SideMenuTab(
                tabIcon: item['tabIcon'],
                title: item['title'],
                route: item['route'],
              ),
            IconButton(
                onPressed: () {
                  SharedPreferencesManager.deleteAccessToken();
                  router.pushReplacement(Pages.auth.screenPath);
                },
                icon: const Icon(Icons.exit_to_app_rounded))
          ],
        ),
      ),
    );
  }
}
