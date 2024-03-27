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

  /// Builds the widget tree for the bar chart.
  ///
  /// This function returns a [SizedBox] containing a [Padding] widget that wraps
  /// a [BarChart] widget. The [BarChart] is configured with various properties
  /// such as titles, border, bar groups, grid, and alignment. The height of the
  /// [SizedBox] is set to 300.
  ///
  /// Parameters:
  /// - `context`: The [BuildContext] of the widget tree.
  ///
  /// Returns:
  /// A [SizedBox] containing a [Padding] widget wrapping a [BarChart] widget.
  Widget build(BuildContext context) {
    // Return a SizedBox containing a Padding widget that wraps a BarChart widget
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            // Configures the bar touch data
            barTouchData: barTouchData,
            // Configures the titles for the chart
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
                ),
              ),
            ),
            // Configures the border of the chart
            borderData: FlBorderData(
              show: false,
            ),
            // Configures the bar groups for the chart
            barGroups: generateBarGroupsData(),
            // Configures the grid lines of the chart
            gridData: FlGridData(show: true),
            // Sets the alignment of the bars in the chart
            alignment: BarChartAlignment.spaceAround,
            // Sets the maximum and minimum values for the Y-axis
            maxY: 10,
            minY: 0,
          ),
        ),
      ),
    );
  }

  /// Generates a list of [BarChartGroupData] representing bar groups for the bar chart.
  ///
  /// This function iterates over the [barsList] and generates a bar group for each
  /// set of bars. It creates two bars for each group, one for male clothes and one
  /// for female clothes. The color and width of each bar is set accordingly.
  ///
  /// Returns:
  /// - A list of [BarChartGroupData] containing all the bar groups.
  List<BarChartGroupData> generateBarGroupsData() {
    List<BarChartGroupData> allGroups =
        []; // Initialize a list to store all groups

    // Iterate over the barsList
    for (int i = 0; i < 7; i++) {
      // Create male bar
      BarChartRodData maleBar = BarChartRodData(
        toY: widget.barsList[0][i]
            .toY, // Set the y-coordinate to the corresponding bar data
        color: Colors.blue, // Use color for male clothes
        width: !Responsive.isDesktop(context)
            ? 10
            : 25, // Set the width of the bar
      );

      // Create female bar
      BarChartRodData femaleBar = BarChartRodData(
        toY: widget.barsList[1][i]
            .toY, // Set the y-coordinate to the corresponding bar data
        color: Colors.pink, // Use color for female clothes
        width: !Responsive.isDesktop(context)
            ? 10
            : 25, // Set the width of the bar
      );

      // Create a list containing both male and female bars
      List<BarChartRodData> bars = [maleBar, femaleBar];

      // Add the bar group to allGroups
      allGroups.add(BarChartGroupData(x: i, barRods: bars));
    }

    return allGroups; // Return the list of all groups
  }

  /// Generates a [Widget] representing a title for a bar in the bar chart.
  ///
  /// This function takes a [double] [value] representing the x-coordinate
  /// of the bar, and a [TitleMeta] [titleMeta] object containing information
  /// about the axis side. It returns a [SideTitleWidget] with a styled
  /// [Text] widget displaying the corresponding day of the week.
  ///
  /// Parameters:
  /// - `value`: The x-coordinate of the bar.
  /// - `titleMeta`: Information about the axis side.
  ///
  /// Returns:
  /// A [SideTitleWidget] containing the styled [Text] widget representing
  /// the title.
  Widget getTitles(double value, TitleMeta titleMeta) {
    // Create a [Text] widget displaying the day of the week
    final Widget text = Text(
      days[value.toInt()], // Retrieve the day from the 'days' list
      style: const TextStyle(
        // Set the color, font weight, and font size of the text
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    // Return a SideTitleWidget containing the text widget
    return SideTitleWidget(
      axisSide: titleMeta.axisSide, // Set the axis side of the widget
      space: 4, // Set the space around the widget
      child: text, // Set the child widget to the text widget
    );
  }

// Get the tooltip data for the bar chart values in the BarTouchData class
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
