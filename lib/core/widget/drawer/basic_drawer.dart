import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/sidemenu/side_menu_tab.dart';

/// Widget representing the drawer
class BasicDrawer extends StatefulWidget {
  final List<Map<String, dynamic>> menuItems;
  const BasicDrawer({super.key, required this.menuItems});

  @override
  State<BasicDrawer> createState() => _BasicDrawerState();
}

class _BasicDrawerState extends State<BasicDrawer> {
  // Builds the drawer widget.
  ///
  /// This widget represents the drawer. It contains a [Drawer] widget
  /// which holds a [Column] widget. The [Column] widget contains a
  /// [DrawerHeader] widget and a list of [SideMenuTab] widgets. Each
  /// [SideMenuTab] widget represents a menu item from the [menuItems] list
  /// stored in [../constants/menu_items.dart] passed to the widget depending on the user role after authentication.
  ///  At the end of the [Column]
  /// widget, there is an [IconButton] widget which allows the user to logout.
  /// On icon click the logout function is called, cleaning the session storage and redirecting the user to the login page.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Set the background color of the drawer to dark brown.
      backgroundColor: AppColors.darkBrown,
      // Wrap the content of the drawer in a SingleChildScrollView.
      child: SingleChildScrollView(
        // Set the children of the Column widget.
        child: Column(
          children: [
            // Display the logo of the admin panel.
            DrawerHeader(
                // Display the logo of the admin panel.
                child: Image.asset("assets/xc-logo-transparent-white.png")),

            // Generate a list of SideMenuTab widgets.
            // Each SideMenuTab widget represents a menu item.
            for (var item in widget.menuItems)
              SideMenuTab(
                // Set the icon of the tab.
                tabIcon: item['tabIcon'],
                // Set the title of the tab.
                title: item['title'],
                // Set the route of the tab.
                route: item['route'],
              ),

            // Display an IconButton which allows the user to logout.
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      tooltip: "logout",
                      // Call the logout function when the button is pressed.
                      onPressed: () {
                        SessionStorage.clearAll();
                        router.pushReplacement(Pages.auth.screenPath);
                      },
                      // Set the icon of the button to an exit to app icon.
                      icon: Icon(
                        Icons.exit_to_app_rounded,
                        color: AppColors.white,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
