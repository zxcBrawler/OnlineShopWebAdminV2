import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';

class AdminTotalActiveUsers extends StatefulWidget {
  final String title;
  const AdminTotalActiveUsers({super.key, required this.title});

  @override
  State<AdminTotalActiveUsers> createState() => _AdminTotalActiveUsersState();
}

class _AdminTotalActiveUsersState extends State<AdminTotalActiveUsers> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 20, top: 20, left: 8, right: 8),
            child: BasicContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    BasicText(title: widget.title),
                    const BasicText(title: "52"),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            router.go(Pages.adminAllActiveUsers.screenPath);
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
        ),
      ],
    );
  }
}
