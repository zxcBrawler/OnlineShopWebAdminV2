import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
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
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: context.read<SideMenuController>().controlMenu,
              icon: const Icon(
                Icons.menu,
                size: 40,
              )),
        ),
        if (Responsive.isMobile(context))
          HeaderText(textSize: 35, title: widget.title)
        else
          HeaderText(textSize: 45, title: widget.title),
        const Spacer(),
        UserInfo(
          username: username ?? "",
        ),
      ],
    );
  }
}
