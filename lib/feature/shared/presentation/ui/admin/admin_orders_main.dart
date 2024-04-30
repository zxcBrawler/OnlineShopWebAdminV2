import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_order_statuses_widget.dart';

import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_orders_pie_chart.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_weekly_orders_widget.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  /// Builds the UI for the [AdminOrders] widget.
  ///
  /// This method returns a [SafeArea] widget that wraps a
  /// [SingleChildScrollView]. Inside the [SingleChildScrollView], there is a
  /// [Column] widget that contains a [Header] widget and two rows. The first
  /// row contains a single widget, [AdminTotalOrders]. The second row contains
  /// a single widget, [AdminWeeklyOrders].
  ///
  /// This method does not take any parameters.
  ///
  /// This method returns a [Widget].
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap the content with SafeArea to avoid any overlap with system UI
      child: SingleChildScrollView(
          // Wrap the content with SingleChildScrollView to enable vertical
          // scrolling
          padding: const EdgeInsets.all(16.0),
          child: Responsive.isDesktop(context)
              ? _buildDesktopUI(context)
              : _buildMobileUI(context)),
    );
  }

  Widget _buildDesktopUI(BuildContext context) {
    return Column(
      // Create a column to stack the widgets vertically
      children: [
        Header(
          // Display the header
          title: S.of(context).allOrders,
        ),
        // Display a row containing the total orders widget
        const Row(
          children: [AdminTotalOrders(), AdminOrderStatuses()],
        ),
        // Display a row containing the weekly orders widget

        const AdminWeeklyOrders(),
      ],
    );
  }

  Widget _buildMobileUI(BuildContext context) {
    return Column(
      // Create a column to stack the widgets vertically
      children: [
        Header(
          // Display the header
          title: S.of(context).allOrders,
        ),
        // Display a row containing the total orders widget
        const Row(
          children: [AdminTotalOrders()],
        ),
        // Display a row containing the weekly orders widget

        const AdminWeeklyOrders(),

        const Row(
          children: [AdminOrderStatuses()],
        )
      ],
    );
  }
}
