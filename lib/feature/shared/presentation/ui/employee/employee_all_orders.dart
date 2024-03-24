import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_orders_table.dart';

class EmployeeAllOrders extends StatefulWidget {
  const EmployeeAllOrders({super.key});

  @override
  State<EmployeeAllOrders> createState() => _EmployeeAllOrdersState();
}

class _EmployeeAllOrdersState extends State<EmployeeAllOrders> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      // Wrap the content with a SingleChildScrollView to allow vertical scrolling
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header widget with the title 'all orders'
            Row(
              children: [
                Expanded(
                  child: Header(
                    title: 'all orders',
                  ),
                ),
              ],
            ),
            // Row with  search bar and three filter icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [],
                  ),
                )
              ],
            ),
            // Orders table widget
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: BasicContainer(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DirectorOrdersTable(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
