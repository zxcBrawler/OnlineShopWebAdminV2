import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xc_web_admin/core/widget/drawer/menu_items.dart';
import 'package:xc_web_admin/core/resources/controller/side_menu_controller.dart';
import 'package:xc_web_admin/core/widget/drawer/basic_drawer.dart';

class EmployeeMainScreen extends StatefulWidget {
  final String? location;
  final Widget? child;
  const EmployeeMainScreen({super.key, this.location, this.child});

  @override
  State<EmployeeMainScreen> createState() => _EmployeeMainScreenState();
}

class _EmployeeMainScreenState extends State<EmployeeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The drawer for the employee panel.
      drawer: BasicDrawer(
        menuItems: employeeMenuItems,
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
