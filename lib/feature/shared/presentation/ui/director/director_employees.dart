import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/employees_table.dart';

class DirectorEmployees extends StatefulWidget {
  const DirectorEmployees({super.key});

  @override
  State<DirectorEmployees> createState() => _DirectorEmployeesState();
}

class _DirectorEmployeesState extends State<DirectorEmployees> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Container that wraps the scrollable widget
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // Column of widgets
        child: Column(
          children: [
            // Header widget with title 'all users'
            const Row(
              children: [
                Expanded(
                  child: Header(
                    title: 'all employees',
                  ),
                ),
              ],
            ),
            // Row with search bar and filter/add buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const BasicSearchBar(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Filter users button
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
                      // Add user button
                      SizedBox(
                          height: 70,
                          width: 70,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BasicContainer(
                                child: IconButton(
                                  onPressed: () {
                                    // Open add user dialog
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const Placeholder();
                                        });
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ))),
                    ],
                  ),
                )
              ],
            ),
            // Row with users table
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
                              child: EmployeesTable()),
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
