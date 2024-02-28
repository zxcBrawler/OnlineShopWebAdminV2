import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/users_table.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_weekly_activity_linechart.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';

class WeeklyActivityDetails extends StatefulWidget {
  const WeeklyActivityDetails({super.key});

  @override
  State<WeeklyActivityDetails> createState() => _WeeklyActivityDetailsState();
}

class _WeeklyActivityDetailsState extends State<WeeklyActivityDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  child: Header(
                    title: 'weekly activity overview',
                  ),
                ),
              ],
            ),
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
                                child:
                                    AdminWeeklyActivityLineChart()), //implement linechart
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const BasicSearchBar(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                              ))),
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
                              ))),
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
                              ))),
                    ],
                  ),
                )
              ],
            ),
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
                            child: Expanded(
                                child: UsersTable()), //implement linechart
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
