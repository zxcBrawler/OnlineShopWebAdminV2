import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/constants.dart';

class BasicBarChart extends StatefulWidget {
  final List<List<BarChartRodData>> barsList;
  const BasicBarChart({super.key, required this.barsList});

  @override
  State<BasicBarChart> createState() => _BasicBarChartState();
}

class _BasicBarChartState extends State<BasicBarChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(BarChartData(
            barTouchData: barTouchData,
            titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  getTitlesWidget: getTitles,
                  showTitles: true,
                ))),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: generateBarGroupsData(),
            gridData: FlGridData(show: true),
            alignment: BarChartAlignment.spaceAround,
            maxY: 50,
            minY: 0)),
      ),
    );
  }

  List<BarChartGroupData> generateBarGroupsData() {
    List<BarChartGroupData> allGroups = [];

    for (int i = 0; i < 7; i++) {
      BarChartRodData maleBar = BarChartRodData(
        toY: widget.barsList[0][i].toY,
        color: Colors.blue, // Use color for male clothes
        width: !Responsive.isDesktop(context) ? 10 : 25,
      );

      BarChartRodData femaleBar = BarChartRodData(
        toY: widget.barsList[1][i].toY,
        color: Colors.pink, // Use color for female clothes
        width: !Responsive.isDesktop(context) ? 10 : 25,
      );

      // Create a list containing both male and female bars
      List<BarChartRodData> bars = [maleBar, femaleBar];

      // Add the bar group to allGroups
      allGroups.add(BarChartGroupData(x: i, barRods: bars));
    }

    return allGroups;
  }

  Widget getTitles(double value, TitleMeta titleMeta) {
    final Widget text = Text(days[value.toInt()],
        style: const TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ));

    return SideTitleWidget(axisSide: titleMeta.axisSide, space: 4, child: text);
  }

  BarTouchData get barTouchData => BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: AppColors.darkBrown,
          tooltipRoundedRadius: 20,
          tooltipPadding: const EdgeInsets.all(8),
          tooltipMargin: 8,
          getTooltipItem: (BarChartGroupData group, int groupIndex,
              BarChartRodData rod, int rodIndex) {
            return BarTooltipItem(
                rod.toY.toString(),
                const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold));
          }));
}
