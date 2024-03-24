import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_weekly_orders_linechart.dart';

class AdminWeeklyOrders extends StatefulWidget {
  const AdminWeeklyOrders({super.key});

  @override
  State<AdminWeeklyOrders> createState() => _AdminWeeklyOrdersState();
}

class _AdminWeeklyOrdersState extends State<AdminWeeklyOrders> {
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
                  const BasicText(title: "weekly orders made overview"),
                  const Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: AdminWeeklyOrdersLinechart()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              router.go(
                                  Pages.adminWeeklyOrdersDetails.screenPath);
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
