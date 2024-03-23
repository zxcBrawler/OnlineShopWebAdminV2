import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_clothes_total_items.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_clothes_weelky_items_sold_overview.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_female_clothes_widget.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_male_clothes_widget.dart';

class DirectorClothes extends StatefulWidget {
  const DirectorClothes({super.key});

  @override
  State<DirectorClothes> createState() => _DirectorClothesState();
}

class _DirectorClothesState extends State<DirectorClothes> {
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
        DirectorTotalItems(),
        Row(
          children: [
            DirectorFemaleClothesWidget(),
            DirectorMaleClothesWidget(),
          ],
        ),
        Row(
          children: [DirectorWeeklyItemsSold()],
        ),
        // AdminWeeklyItemsSold(),
      ],
    );
  }

  Widget _buildMobileUI(BuildContext context) {
    return const Column(
      children: [
        Header(title: 'clothes info'),
        DirectorTotalItems(),
        Row(
          children: [
            DirectorFemaleClothesWidget(),
          ],
        ),
        Row(
          children: [
            DirectorMaleClothesWidget(),
          ],
        ),
      ],
    );
  }
}
