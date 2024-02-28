import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: !Responsive.isDesktop(context)
              ? const Column(
                  children: [
                    Header(
                      title: 'clothes info',
                    ),
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
                  ],
                )
              : const Column(
                  children: [
                    Header(
                      title: 'clothes info',
                    ),
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
                  ],
                )),
    );
  }
}
