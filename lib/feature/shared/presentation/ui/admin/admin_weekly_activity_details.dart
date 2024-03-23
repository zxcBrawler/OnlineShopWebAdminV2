import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_weekly_activity_linechart.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/users_table.dart';

class WeeklyActivityDetails extends StatefulWidget {
  const WeeklyActivityDetails({super.key});

  @override
  State<WeeklyActivityDetails> createState() => _WeeklyActivityDetailsState();
}

class _WeeklyActivityDetailsState extends State<WeeklyActivityDetails> {
  @override

  /// Builds the widget tree for the weekly activity details screen.
  ///
  /// The screen consists of several components:
  /// - A header widget
  /// - A scrollable area containing a line chart, search bar, and a table
  ///   of active users.
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header widget
            const Row(
              children: [
                Expanded(
                  child: Header(
                    title: 'weekly activity overview',
                  ),
                ),
              ],
            ),
            // Line chart
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: BasicContainer(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30, right: 30),
                            child: SizedBox(
                                height: 400,
                                child: AdminWeeklyActivityLineChart()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Search bar and filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildFilterButton(),
                    ],
                  ),
                ),
              ],
            ),
            // Active users table
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: BasicContainer(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Expanded(child: UsersTable()),
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

  /// Builds a single filter button widget.
  Widget _buildFilterButton() {
    return SizedBox(
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
    );
  }
}
