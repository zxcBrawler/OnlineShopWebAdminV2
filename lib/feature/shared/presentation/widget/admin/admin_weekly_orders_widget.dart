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

  /// Builds the AdminWeeklyOrders widget.
  ///
  /// This method builds the UI for the AdminWeeklyOrders widget. It returns a
  /// Row widget that contains an Expanded widget with a Padding widget. The
  /// Padding widget wraps a BasicContainer widget. The BasicContainer widget
  /// contains a Column widget with several child widgets.
  ///
  /// The Column widget has a BasicText widget displaying "weekly orders made
  /// overview" and another Padding widget wrapping an AdminWeeklyOrdersLinechart
  /// widget. At the end of the Column widget, there is a Row widget with an
  /// IconButton widget.
  ///
  /// The IconButton widget has an onPressed callback that navigates to the
  /// adminWeeklyOrdersDetails screen when pressed.
  Widget build(BuildContext context) {
    return Row(
      // The Row widget contains the AdminWeeklyOrders widget.
      children: [
        Expanded(
          // The Expanded widget expands to fill the available space.
          child: Padding(
            // The Padding widget adds padding to the BasicContainer widget.
            padding: const EdgeInsets.all(8.0),
            // The Padding widget wraps a BasicContainer widget.
            child: BasicContainer(
              // The BasicContainer widget wraps a Column widget.
              child: Column(
                // The Column widget contains several child widgets.
                children: [
                  const BasicText(
                    // The BasicText widget displays "weekly orders made overview".
                    title: "weekly orders made overview",
                  ),
                  const Padding(
                      // The Padding widget adds right padding to the
                      // AdminWeeklyOrdersLinechart widget.
                      padding: EdgeInsets.only(right: 30),
                      // The Padding widget wraps an AdminWeeklyOrdersLinechart widget.
                      child: AdminWeeklyOrdersLinechart()),
                  Row(
                    // The Row widget aligns its children to the end.
                    mainAxisAlignment: MainAxisAlignment.end,
                    // The Row widget contains an IconButton widget.
                    children: [
                      Padding(
                        // The Padding widget adds padding to the IconButton widget.
                        padding: const EdgeInsets.all(8.0),
                        // The Padding widget wraps an IconButton widget.
                        child: IconButton(
                            // The IconButton widget has no padding.
                            padding: EdgeInsets.zero,
                            // The onPressed callback navigates to the
                            // adminWeeklyOrdersDetails screen when pressed.
                            onPressed: () {
                              router.go(
                                  Pages.adminWeeklyOrdersDetails.screenPath);
                            },
                            // The IconButton widget displays a chevron_right icon.
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
