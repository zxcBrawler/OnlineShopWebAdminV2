import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_orders_table.dart';

class AdminAllOrders extends StatefulWidget {
  const AdminAllOrders({super.key});

  @override
  State<AdminAllOrders> createState() => _AdminAllOrdersState();
}

class _AdminAllOrdersState extends State<AdminAllOrders> {
  @override

  /// Builds the widget tree for the [AdminAllOrders] widget.
  ///
  /// This widget tree includes a [SafeArea] widget, which ensures that
  /// the child widget is not affected by the padding of the device.
  /// Inside the [SafeArea], there is a [SingleChildScrollView], which
  /// allows the user to scroll vertically if the content overflows.
  /// The [Column] widget is used to stack the child widgets vertically.
  ///
  /// The first child of the [Column] is a [Row], which includes a
  /// [Header] widget with the title 'all orders'.
  /// The second child of the [Column] is another [Row], which includes
  /// three [BasicSearchBar] widgets, and one [Row] widget with three
  /// [IconButton] widgets.
  /// The last child of the [Column] is another [Row], which includes
  /// a [BasicContainer] widget with a [Padding] widget as a child.
  /// Inside the [Padding] widget, there is another [Column] widget with
  /// a [Padding] widget as a child. Inside the [Padding] widget, there is
  /// a [OrdersTable] widget.
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
                            child: OrdersTable(),
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
