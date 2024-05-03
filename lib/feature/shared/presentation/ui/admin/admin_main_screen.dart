import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xc_web_admin/core/widget/drawer/menu_items.dart';
import 'package:xc_web_admin/core/resources/controller/side_menu_controller.dart';
import 'package:xc_web_admin/core/widget/drawer/basic_drawer.dart';

class AdminMainScreen extends StatefulWidget {
  final String? location;
  final Widget? child;
  const AdminMainScreen({super.key, this.location, this.child});

  @override
  State<AdminMainScreen> createState() => AdminMainScreenState();
}

class AdminMainScreenState extends State<AdminMainScreen> {
  @override

  /// The main screen widget for the admin panel.
  ///
  /// This widget builds a Scaffold that includes a drawer and a body. The
  /// body is a SafeArea that contains a Row with a single child: [widget.child].
  ///
  /// The [widget.child] is the child widget that is displayed in the body.
  /// The [widget.child] is passed to the widget when it is created.
  ///
  /// The scaffold also has a key that is obtained from the [SideMenuController].
  Widget build(BuildContext context) {
    return Scaffold(
      // The drawer for the admin panel.
      drawer: BasicDrawer(
        menuItems: adminMenuItems(context),
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
