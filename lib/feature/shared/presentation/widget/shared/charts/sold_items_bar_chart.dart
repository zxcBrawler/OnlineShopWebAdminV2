import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/responsive.dart';

import '../../../../../../core/constants/constants.dart';

class MyBarChart extends StatefulWidget {
  const MyBarChart({super.key});

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  List<double> femaleItemsSold = [
    150,
    500,
    476,
    390,
    598,
    145,
    500
  ]; // get this data from db
  List<double> maleItemsSold = [
    400,
    200,
    298,
    312,
    177,
    598,
    388
  ]; // get this data from db
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  @override
  Widget build(BuildContext context) {
    final monSales =
        makeGroupData(0, femaleItemsSold[0], maleItemsSold[0], context);
    final tueSales =
        makeGroupData(1, femaleItemsSold[1], maleItemsSold[1], context);
    final wedSales =
        makeGroupData(2, femaleItemsSold[2], maleItemsSold[2], context);
    final thuSales =
        makeGroupData(3, femaleItemsSold[3], maleItemsSold[3], context);
    final friSales =
        makeGroupData(4, femaleItemsSold[4], maleItemsSold[4], context);
    final satSales =
        makeGroupData(5, femaleItemsSold[5], maleItemsSold[5], context);
    final sunSales =
        makeGroupData(6, femaleItemsSold[6], maleItemsSold[6], context);

    final items = [
      monSales,
      tueSales,
      wedSales,
      thuSales,
      friSales,
      satSales,
      sunSales,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;

    return BarChart(BarChartData(
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
        borderData: borderData,
        barGroups: showingBarGroups,
        gridData: FlGridData(show: true),
        alignment: BarChartAlignment.spaceAround,
        maxY: 600,
        minY: 0));
  }
}

BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 8,
        getTooltipItem: (BarChartGroupData group, int groupIndex,
            BarChartRodData rod, int rodIndex) {
          return BarTooltipItem(rod.toY.toString(),
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
        }));

Widget getTitles(double value, TitleMeta titleMeta) {
  final Widget text = Text(days[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ));

  return SideTitleWidget(axisSide: titleMeta.axisSide, space: 4, child: text);
}

FlBorderData get borderData => FlBorderData(
      show: false,
    );

BarChartGroupData makeGroupData(
    int x, double y1, double y2, BuildContext context) {
  return BarChartGroupData(
    barsSpace: !Responsive.isDesktop(context) ? 2 : 4,
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        color: Colors.pink,
        width: !Responsive.isDesktop(context) ? 10 : 25,
      ),
      BarChartRodData(
        toY: y2,
        color: Colors.blue,
        width: !Responsive.isDesktop(context) ? 10 : 25,
      ),
    ],
  );
}
