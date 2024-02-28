import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';

class AdminTotalItemsPiechart extends StatefulWidget {
  const AdminTotalItemsPiechart({super.key});

  @override
  State<AdminTotalItemsPiechart> createState() =>
      _AdminTotalItemsPiechartState();
}

class _AdminTotalItemsPiechartState extends State<AdminTotalItemsPiechart> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
        child: BasicContainer(
          child: Column(
            children: [
              const BasicText(title: "total items"),

              // TODO:
              SizedBox(
                height: 300,
                child: PieChart(
                  PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: double.infinity,
                      sections: [
                        PieChartSectionData(
                            color: Colors.blue,
                            value: 15,
                            radius: 50,
                            showTitle: false),
                        PieChartSectionData(
                            color: Colors.pink,
                            value: 10,
                            radius: 50,
                            showTitle: false),
                      ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // router
                        //     .go(Pages.adminWeeklyActivityDetails.screenPath);
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                        size: 30,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
