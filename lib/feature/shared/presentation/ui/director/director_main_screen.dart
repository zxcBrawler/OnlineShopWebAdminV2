import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xc_web_admin/core/constants/menu_items.dart';
import 'package:xc_web_admin/core/resources/controller/side_menu_controller.dart';
import 'package:xc_web_admin/core/widget/basic_drawer.dart';

class DirectorMainScreen extends StatefulWidget {
  final String? location;
  final Widget? child;
  const DirectorMainScreen({super.key, this.location, this.child});

  @override
  State<DirectorMainScreen> createState() => _DirectorMainScreenState();
}

class _DirectorMainScreenState extends State<DirectorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The drawer for the admin panel.
      drawer: BasicDrawer(
        menuItems: directorMenuItems,
      ),
      // The key for the Scaffold. The key is obtained from the SideMenuController.
      key: context.read<SideMenuController>().scaffoldKey,
      // The body of the Scaffold.
      body: SafeArea(
        // The child widget that is displayed in the body.
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The child widget that is passed to the widget when it is created.
            Expanded(
              flex: 6,
              child: widget.child!,
            ),
          ],
        ),
      ),
    );
  }
}
