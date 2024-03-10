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
  /// Widget representing the admin drawer.
  ///
  /// This widget is responsible for displaying the admin drawer.
  /// It contains a [Drawer] widget which holds a [Column] widget.
  /// The [Column] widget contains a [DrawerHeader] widget and a list of
  /// [SideMenuTab] widgets. Each [SideMenuTab] widget represents a menu item
  /// from the [adminMenuItems] list stored in [../constants/menu_items.dart].
  /// At the end of the [Column] widget, there is an [IconButton] widget which
  /// allows the user to logout.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Set the background color of the drawer to dark brown.
      backgroundColor: AppColors.darkBrown,
      // Wrap the content of the drawer in a SingleChildScrollView.
      child: SingleChildScrollView(
        child: Column(
          // Set the children of the Column widget.
          children: [
            // Display the logo of the admin panel.
            DrawerHeader(
                child: Image.asset("assets/xc-logo-transparent-white.png")),

            // Generate a list of SideMenuTab widgets.
            // Each SideMenuTab widget represents a menu item.
            for (var item in adminMenuItems)
              SideMenuTab(
                // Set the icon of the tab.
                tabIcon: item['tabIcon'],
                // Set the title of the tab.
                title: item['title'],
                // Set the route of the tab.
                route: item['route'],
              ),

            // Display an IconButton which allows the user to logout.
            IconButton(
                // Call the logout function when the button is pressed.
                onPressed: () {
                  SharedPreferencesManager.deleteAccessToken();
                  router.pushReplacement(Pages.auth.screenPath);
                },
                // Set the icon of the button to an exit to app icon.
                icon: const Icon(Icons.exit_to_app_rounded))
          ],
        ),
      ),
    );
  }
}
