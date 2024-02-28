import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/shared/charts/sold_items_bar_chart.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/icon/basic_icon.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';

class AdminWeeklyItemsSold extends StatelessWidget {
  const AdminWeeklyItemsSold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: BasicContainer(
              child: Column(
                children: [
                  BasicText(title: "weekly sold items overview"),
                  Padding(
                    padding: EdgeInsets.only(right: 30),
                    child: SizedBox(height: 300, child: MyBarChart()),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BasicIcon(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
