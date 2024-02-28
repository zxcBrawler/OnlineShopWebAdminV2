import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';

class UserAddresses extends StatefulWidget {
  final String title;
  const UserAddresses({super.key, required this.title});

  @override
  State<UserAddresses> createState() => _UserAddressesState();
}

class _UserAddressesState extends State<UserAddresses> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 20, left: 8, right: 8),
        child: BasicContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                BasicText(title: widget.title),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        router.go(Pages.adminUserAddresses.screenPath);
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                        size: 35,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
