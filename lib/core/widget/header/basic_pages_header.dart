import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/resources/controller/side_menu_controller.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/header/user_info.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.title});
  final String title;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override

  /// Builds the header widget.
  ///
  /// The header includes a menu icon, a title, and user information.
  /// The menu icon toggles the side menu when pressed.
  /// The title is displayed using the [HeaderText] widget.
  /// The user information is displayed using the [UserInfo] widget.
  /// The widget is built using a [Row] widget.
  /// The padding of the menu icon is set to 16 on all sides.
  /// The size of the menu icon is set to 40.
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Menu icon
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: context.read<SideMenuController>().controlMenu,
            icon: const Icon(
              Icons.menu,
              size: 40,
            ),
          ),
        ),
        // Title
        if (Responsive.isMobile(context))
          HeaderText(textSize: 35, title: widget.title)
        else
          HeaderText(textSize: 45, title: widget.title),
        // Spacer to fill available space
        const Spacer(),
        // User information
        UserInfo(
          username: SessionStorage.getValue('username'),
        ),
      ],
    );
  }
}
