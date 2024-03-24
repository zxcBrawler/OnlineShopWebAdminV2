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

  Widget _buildDesktopUI(BuildContext context) {
    return const Column(
      children: [
        Header(title: 'clothes info'),
        EmployeeTotalItems(),
        Row(
          children: [
            EmployeeFemaleItemsWidget(),
            EmployeeMaleItemsWidget(),
          ],
        ),

        // AdminWeeklyItemsSold(),
      ],
    );
  }

  Widget _buildMobileUI(BuildContext context) {
    return const Column(
      children: [
        Header(title: 'clothes info'),
        EmployeeTotalItems(),
        Row(
          children: [
            EmployeeFemaleItemsWidget(),
          ],
        ),
        Row(
          children: [
            EmployeeMaleItemsWidget(),
          ],
        ),
      ],
    );
  }
}
