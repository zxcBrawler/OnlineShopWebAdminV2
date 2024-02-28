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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: AppColors.white),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: ListTile(
              leading: Icon(
                widget.tabIcon,
                size: 40,
              ),
              iconColor: AppColors.darkBrown,
              title: SideMenuTitle(title: widget.title),
              trailing: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    router.go(widget.route);
                    router.pop(context);
                  },
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 35,
                  ))),
        ),
      ),
    );
  }
}
