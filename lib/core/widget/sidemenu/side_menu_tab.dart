import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/widget/sidemenu/side_menu_title.dart';

class SideMenuTab extends StatefulWidget {
  final IconData tabIcon;
  final String title;
  final String route;
  const SideMenuTab({
    super.key,
    required this.tabIcon,
    required this.title,
    required this.route,
  });

  @override
  State<SideMenuTab> createState() => _SideMenuTabState();
}

class _SideMenuTabState extends State<SideMenuTab> {
  @override

  /// Builds the SideMenuTab widget.
  ///
  /// The SideMenuTab widget represents a single tab in the side menu.
  /// It contains an icon, a title, and a navigation button.
  /// When the navigation button is pressed, it navigates to the specified route.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Padding around the container
      child: Container(
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(20.0), // Border radius of the container
            color: AppColors.white), // Background color of the container
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 8.0, bottom: 8.0), // Padding inside the container
          child: ListTile(
              // ListTile widget containing the icon, title, and navigation button
              leading: Icon(
                widget.tabIcon, // Icon displayed in the leading position
                size: 40, // Size of the icon
              ),
              iconColor: AppColors.darkBrown, // Color of the icon
              title: SideMenuTitle(
                  title: widget
                      .title), // SideMenuTitle widget containing the title
              trailing: IconButton(
                  padding:
                      EdgeInsets.zero, // No padding for the navigation button
                  onPressed: () {
                    router.go(widget.route); // Navigate to the specified route
                    router.pop(context); // Pop the current route from the stack
                  },
                  icon: const Icon(
                    Icons
                        .chevron_right, // Icon displayed in the trailing position
                    size: 35, // Size of the icon
                  ))), // Navigation button with a chevron icon
        ),
      ),
    );
  }
}
