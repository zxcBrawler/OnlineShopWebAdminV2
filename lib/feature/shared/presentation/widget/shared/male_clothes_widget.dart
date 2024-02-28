import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';

class MaleClothesWidget extends StatefulWidget {
  const MaleClothesWidget({super.key});

  @override
  State<MaleClothesWidget> createState() => _MaleClothesWidgetState();
}

class _MaleClothesWidgetState extends State<MaleClothesWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BasicContainer(
          child: Column(
            children: [
              const BasicText(title: "total male items"),

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
                            color: Colors.red,
                            value: 10,
                            radius: 50,
                            showTitle: false),
                        PieChartSectionData(
                            color: Colors.purple,
                            value: 20,
                            radius: 50,
                            showTitle: false),
                        PieChartSectionData(
                            color: Colors.pink,
                            value: 23,
                            radius: 50,
                            showTitle: false),
                        PieChartSectionData(
                            color: Colors.greenAccent,
                            value: 32,
                            radius: 50,
                            showTitle: false),
                      ]),
                  // swapAnimationDuration:
                  //     Duration(milliseconds: 150), // Optional
                  // swapAnimationCurve: Curves.linear,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // router
                          //     .go(Pages.adminWeeklyActivityDetails.screenPath);
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          size: 35,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
