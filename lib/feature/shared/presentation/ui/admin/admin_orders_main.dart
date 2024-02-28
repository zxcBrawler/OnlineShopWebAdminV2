import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/shared/charts/total_orders_pie_chart.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/shared/weekly_orders_widget.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Header(
                title: 'orders',
              ),
              Row(
                children: [
                  AdminTotalOrders(),
                ],
              ),
              AdminWeeklyOrders(),
            ],
          )),
    );
  }
}
