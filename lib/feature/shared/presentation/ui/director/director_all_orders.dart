import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';

import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_orders_table.dart';

class DirectorAllOrders extends StatefulWidget {
  const DirectorAllOrders({super.key});

  @override
  State<DirectorAllOrders> createState() => _DirectorAllOrdersState();
}

class _DirectorAllOrdersState extends State<DirectorAllOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap the content with a SingleChildScrollView to allow vertical scrolling
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header widget with the title 'all orders'
            const Row(
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
                const BasicSearchBar(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Filter icon 1
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BasicContainer(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.filter_alt),
                            ),
                          ),
                        ),
                      ),
                      // Filter icon 2
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BasicContainer(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.filter),
                            ),
                          ),
                        ),
                      ),
                      // Filter icon 3
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BasicContainer(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.filter),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Orders table widget
            const Row(
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
