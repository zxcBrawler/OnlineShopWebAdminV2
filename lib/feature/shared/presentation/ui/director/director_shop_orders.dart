import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_order_statuses_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_total_orders.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_weekly_orders_widget.dart';

class DirectorShopOrders extends StatefulWidget {
  const DirectorShopOrders({super.key});

  @override
  State<DirectorShopOrders> createState() => _DirectorShopOrdersState();
}

class _DirectorShopOrdersState extends State<DirectorShopOrders> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      // Wrap the content with SafeArea to avoid any overlap with system UI
      child: SingleChildScrollView(
          // Wrap the content with SingleChildScrollView to enable vertical
          // scrolling
          padding: EdgeInsets.all(16.0),
          child: Column(
            // Create a column to stack the widgets vertically
            children: [
              Header(
                // Display the header
                title: 'shop orders',
              ),
              // Display a row containing the total orders widget
              Row(
                children: [
                  DirectorTotalOrders(),
                ],
              ),
              // Display a row containing the weekly orders widget

              DirectorWeeklyOrdersWidget(),

              Row(
                children: [DirectorOrderStatuses()],
              )
            ],
          )),
    );
  }
}
