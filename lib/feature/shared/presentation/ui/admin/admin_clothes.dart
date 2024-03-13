import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_colors.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_total_sizes.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/shared/female_clothes_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/shared/male_clothes_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_clothes_total_items.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_clothes_top_sold_items_.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_clothes_weekly_items_sold_overview.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/config/responsive.dart';

class AdminClothes extends StatefulWidget {
  const AdminClothes({super.key});

  @override
  State<AdminClothes> createState() => _AdminClothesState();
}

class _AdminClothesState extends State<AdminClothes> {
  @override

  /// Builds the user interface representing the [AdminClothes] widget.
  ///
  /// This method builds the UI based on the device's screen size and
  /// device type (desktop or mobile). It returns a [SafeArea] widget
  /// containing a [SingleChildScrollView] widget. The [SingleChildScrollView]
  /// is configured to have padding of 16 pixels all around.
  ///
  /// The UI is structured as follows:
  /// - If the device is a desktop, it displays a column containing
  ///   the header, the total items, and two rows containing female and
  ///   male clothes widgets, and two rows containing top sold items.
  /// - If the device is not a desktop, it displays a column containing
  ///   the header, the total items, and two rows containing female and
  ///   male clothes widgets, and two rows containing top sold items.
  Widget build(BuildContext context) {
    // Return the UI
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
  Widget _buildDesktopUI(BuildContext context) {
    return const Column(
      children: [
        Header(title: 'clothes info'),
        AdminTotalItems(),
        Row(
          children: [
            FemaleClothesWidget(),
            MaleClothesWidget(),
          ],
        ),
        Row(
          children: [
            AdminTopSoldItemsClothesWidget(
              title: "top sold female items",
            ),
            AdminTopSoldItemsClothesWidget(
              title: "top sold male items",
            ),
          ],
        ),
        AdminWeeklyItemsSold(),
        Row(
          children: [
            Expanded(child: AdminColors()),
            Expanded(child: AdminSizes())
          ],
        )
      ],
    );
  }

  /// Builds the UI for a mobile device.
  Widget _buildMobileUI(BuildContext context) {
    return const Column(
      children: [
        Header(title: 'clothes info'),
        AdminTotalItems(),
        Row(
          children: [
            FemaleClothesWidget(),
          ],
        ),
        Row(
          children: [
            MaleClothesWidget(),
          ],
        ),
        Row(
          children: [
            AdminTopSoldItemsClothesWidget(
              title: "top sold female items",
            ),
          ],
        ),
        Row(
          children: [
            AdminTopSoldItemsClothesWidget(
              title: "top sold male items",
            ),
          ],
        ),
        AdminWeeklyItemsSold(),
        AdminColors(),
        AdminSizes()
      ],
    );
  }
}
