import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdminWeeklyActivityLineChart extends StatefulWidget {
  const AdminWeeklyActivityLineChart({super.key});

  @override
  State<AdminWeeklyActivityLineChart> createState() =>
      _AdminWeeklyActivityLineChartState();
}

class _AdminWeeklyActivityLineChartState
    extends State<AdminWeeklyActivityLineChart> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
    );
  }

  LineChartData get sampleData1 => LineChartData(
        gridData: FlGridData(show: false),
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
              interval: 1,
              getTitlesWidget: getTitles,
              showTitles: true,
            ))),
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxY: 200,
        minY: 0,
        maxX: 6,
      );
}

List<LineChartBarData> get lineBarsData => [sample1];

Widget getTitles(double value, TitleMeta titleMeta) {
  List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

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

LineChartBarData get sample1 => LineChartBarData(
        isCurved: true,
        color: Colors.blue,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0, 90),
          FlSpot(1, 150),
          FlSpot(2, 198),
          FlSpot(3, 20),
          FlSpot(4, 200),
          FlSpot(5, 78),
          FlSpot(6, 166),
        ]);
