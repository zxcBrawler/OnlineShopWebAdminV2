import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_shops_table.dart';

class AdminShops extends StatefulWidget {
  const AdminShops({super.key});

  @override
  State<AdminShops> createState() => _AdminShopsState();
}

class _AdminShopsState extends State<AdminShops> {
  @override

  /// Builds the UI for the [AdminShops] widget.
  ///
  /// This method returns a [SafeArea] widget that contains a [SingleChildScrollView]
  /// widget. The [SingleChildScrollView] widget is used to handle the scrolling
  /// behavior of the widget. The [padding] property of the [SingleChildScrollView]
  /// is set to `EdgeInsets.all(16.0)` to provide padding around the widget.
  ///
  /// Inside the [SingleChildScrollView], there is a [Column] widget that contains
  /// the UI for the [AdminShops] widget. The UI starts with a [Header] widget that
  /// displays the title 'shops'.
  ///
  /// After the [Header] widget, there is a [Row] widget that contains a single
  /// child. Inside the [Row], there is an [Expanded] widget that contains a
  /// [Padding] widget. The [padding] property of the [Padding] widget is set to
  /// `EdgeInsets.all(8.0)` to provide padding around the child widget.
  ///
  /// The child widget of the [Padding] widget is a [BasicContainer] widget. Inside
  /// the [BasicContainer], there is a [Column] widget that contains a single
  /// child. This child is the [AdminShopsTable] widget, which displays the table
  /// of shops.
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap the widget with SafeArea to handle safe insets
      child: SingleChildScrollView(
        // Wrap the widget with SingleChildScrollView to handle scrolling behavior
        padding: const EdgeInsets.all(16.0),
        // Set the padding around the widget
        child: Column(
          // Display the UI for the AdminShops widget in a column
          children: [
            const Header(
              // Display the title 'shops' in a header
              title: 'shops',
            ),
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
            const Row(
              // Display the UI for the AdminShopsTable widget in a row
              children: [
                Expanded(
                  // Expand the child widget to fill the available space
                  child: Padding(
                    // Apply padding to the child widget
                    padding: EdgeInsets.all(8.0),
                    // Set the padding around the child widget
                    child: BasicContainer(
                      // Wrap the child widget with BasicContainer
                      child: Column(
                        // Display the UI for the AdminShopsTable widget in a column
                        children: [
                          Padding(
                            // Apply padding to the child widget
                            padding: EdgeInsets.all(8.0),
                            // Set the padding around the child widget
                            child: AdminShopsTable(),
                            // Display the table of shops
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
