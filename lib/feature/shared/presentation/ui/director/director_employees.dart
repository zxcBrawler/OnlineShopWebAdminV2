import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
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
    return const SafeArea(
      // Container that wraps the scrollable widget
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        // Column of widgets
        child: Column(
          children: [
            // Header widget with title 'all users'
            Row(
              children: [
                Expanded(
                  child: Header(
                    title: 'all employees',
                  ),
                ),
              ],
            ),
            // Row with search bar and filter/add buttons

            // Row with users table
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
