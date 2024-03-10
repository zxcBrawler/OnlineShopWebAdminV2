import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_users.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/shared/charts/total_items_piechart.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/shared/charts/total_orders_pie_chart.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();
  }

  /// Builds the UI for the [AdminDashboard] widget.
  ///
  /// This method builds the user interface for the [AdminDashboard] widget.
  /// It uses the [SafeArea] widget to ensure that the scrollable content
  /// is not affected by the system's safe area. It also uses the [SingleChildScrollView]
  /// widget to enable scrolling on small devices. The UI is built using a
  /// responsive approach, adapting to different screen sizes. If the device is
  /// a desktop, it displays the header, and a row containing the total users,
  /// total orders, and total items piechart. If the device is not a desktop,
  /// it displays the header and three rows, each containing a widget displaying
  /// the total users, total orders, and total items piechart respectively.
  ///
  /// Parameters:
  ///   - context: The build context of the widget.
  ///
  /// Returns:
  ///   A widget displaying the user interface for the [AdminDashboard] widget.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap the content with SafeArea to avoid any overlap with system UI
      child: SingleChildScrollView(
          // Wrap the content with SingleChildScrollView to enable vertical scrolling
          padding: const EdgeInsets.all(16.0),
          child: Responsive.isDesktop(context)
              ? const Column(
                  // Build the UI for a desktop device
                  children: [
                    Header(
                      // Display the header
                      title: 'dashboard',
                    ),
                    Row(
                      // Display a row containing the total users, total orders, and total items piechart
                      children: [
                        AdminTotalUsers(),
                        AdminTotalOrders(),
                        AdminTotalItemsPiechart(),
                      ],
                    ),
                  ],
                )
              : const Column(
                  // Build the UI for a non-desktop device
                  children: [
                    Header(
                      // Display the header
                      title: 'dashboard',
                    ),
                    // Display a row containing the total users widget
                    Row(children: [AdminTotalUsers()]),
                    // Display a row containing the total orders widget
                    Row(children: [AdminTotalOrders()]),
                    // Display a row containing the total items piechart widget
                    Row(children: [AdminTotalItemsPiechart()]),
                  ],
                )),
    );
  }
}
