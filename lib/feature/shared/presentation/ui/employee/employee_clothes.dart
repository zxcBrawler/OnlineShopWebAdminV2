import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/employee/employee_female_items_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/employee/employee_male_items_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/employee/employee_total_items.dart';

class EmployeeClothes extends StatefulWidget {
  const EmployeeClothes({super.key});

  @override
  State<EmployeeClothes> createState() => _EmployeeClothesState();
}

class _EmployeeClothesState extends State<EmployeeClothes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          // Check if the device is a desktop
          child: Responsive.isDesktop(context)
              ? _buildDesktopUI(context)
              : _buildMobileUI(context)),
    );
  }

  /// Builds the UI for a desktop device.
  ///
  /// This function returns a Column widget containing a Header widget with
  /// the title 'clothes info', an EmployeeTotalItems widget, and a Row widget
  /// containing EmployeeFemaleItemsWidget and EmployeeMaleItemsWidget.
  Widget _buildDesktopUI(BuildContext context) {
    // The Column widget is used to stack its children vertically.
    return const Column(
      // The Header widget displays the title 'clothes info'.
      children: [
        Header(title: 'clothes info'),
        // The EmployeeTotalItems widget displays the total number of clothes.
        EmployeeTotalItems(),
        // The Row widget is used to stack its children horizontally.
        Row(
          // The EmployeeFemaleItemsWidget and EmployeeMaleItemsWidget are stacked
          // horizontally.
          children: [
            EmployeeFemaleItemsWidget(),
            EmployeeMaleItemsWidget(),
          ],
        ),
      ],
    );
  }

  /// Builds the UI for a mobile device.
  ///
  /// This function returns a Column widget containing a Header widget with
  /// the title 'clothes info', an EmployeeTotalItems widget, and two Row widgets.
  /// The first Row widget contains an EmployeeFemaleItemsWidget, and the second
  /// Row widget contains an EmployeeMaleItemsWidget.
  Widget _buildMobileUI(BuildContext context) {
    return const Column(
      // Contains the title 'clothes info' and the total number of clothes
      children: [
        Header(title: 'clothes info'),
        EmployeeTotalItems(),
        // Contains the number of female clothes
        Row(
          children: [
            EmployeeFemaleItemsWidget(),
          ],
        ),
        // Contains the number of male clothes
        Row(
          children: [
            EmployeeMaleItemsWidget(),
          ],
        ),
      ],
    );
  }
}
