import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_weekly_activity_linechart.dart';

import '../../../../../core/routes/router_utils.dart';

class AdminUsersWeeklyActivity extends StatefulWidget {
  const AdminUsersWeeklyActivity({super.key});

  @override
  State<AdminUsersWeeklyActivity> createState() =>
      _AdminUsersWeeklyActivityState();
}

class _AdminUsersWeeklyActivityState extends State<AdminUsersWeeklyActivity> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BasicContainer(
              child: Column(
                children: [
                  const BasicText(title: "weekly activity overview"),
                  const Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: SizedBox(
                        height: 250,
                        child:
                            AdminWeeklyActivityLineChart()), //implement linechart
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              router.go(
                                  Pages.adminWeeklyActivityDetails.screenPath);
                            },
                            icon: const Icon(
                              Icons.chevron_right,
                              size: 35,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
