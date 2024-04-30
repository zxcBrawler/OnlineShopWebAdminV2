import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_weekly_orders_linechart.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class DirectorWeeklyOrdersWidget extends StatefulWidget {
  const DirectorWeeklyOrdersWidget({super.key});

  @override
  State<DirectorWeeklyOrdersWidget> createState() =>
      _DirectorWeeklyOrdersWidgetState();
}

class _DirectorWeeklyOrdersWidgetState
    extends State<DirectorWeeklyOrdersWidget> {
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
                  BasicText(title: S.current.weeklyOrdersMadeOverview),
                  const Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: DirectorWeeklyOrdersLinechart()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              SessionStorage.getValue('role') == 'director'
                                  ? router.go(Pages
                                      .directorWeeklyOrdersDetails.screenPath)
                                  : router.go(Pages
                                      .employeeWeeklyOrdersDetails.screenPath);
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
