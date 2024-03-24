import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/widget/other/indicator.dart';

class BasicLineChart extends StatefulWidget {
  // List of FlSpot lists for each line in the chart
  final List<List<FlSpot>> spotsList;

  // List of titles for each line in the chart
  final List<String> titles;

  const BasicLineChart(
      {super.key, required this.spotsList, required this.titles});

  @override
  State<BasicLineChart> createState() => _BasicLineChartState();
}

class _BasicLineChartState extends State<BasicLineChart> {
  // List of colors for each line in the chart
  late List<Color> colors;

  @override
  void initState() {
    super.initState();
    // Generate random colors for each list of spots
    colors = List.generate(
      widget.spotsList.length,
      (index) =>
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Expanded widget containing a LineChart.
        ///
        /// This widget represents an expanded area containing a LineChart. The LineChart
        /// is configured using the provided LineChartData, which includes grid, titles,
        /// border, and other chart configurations. The actual data for the line bars is
        /// generated using the [generateLineBarsData] function.
        ///
        /// Returns:
        /// - An [Expanded] widget containing a [LineChart].
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                // Chart configurations
                gridData: FlGridData(show: false), // Hide grid lines
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
                      getTitlesWidget:
                          getTitles, // Define titles on the bottom axis
                      showTitles: true,
                    ))),
                borderData: FlBorderData(
                  show: false, // Hide chart border
                ),
                lineBarsData: generateLineBarsData(), // Generate line bars data
                minX: 0, // Set minimum X-axis value
                maxY: 10, // Set maximum Y-axis value
                minY: 0, // Set minimum Y-axis value
                maxX: 6, // Set maximum X-axis value
              ),
            ),
          ),
        ),

        /// Builds a row of indicators based on the titles and their corresponding colors.
        ///
        /// This widget creates a row of indicators, each representing a title from the
        /// provided list of titles. The indicator color is determined by the
        /// [getColorForTitle] function.
        ///
        /// Returns:
        /// - A [Row] widget containing a list of [Indicator] widgets.
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Align the row in the center
          children: widget.titles.map((title) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Indicator(
                    color:
                        getColorForTitle(title), // Get color based on the title
                    text: title, // Set the text of the indicator
                    isSquare: false,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Generates titles for the axis based on the provided value and title metadata.
  ///
  /// This function is used to create titles for the axis in the line chart. It takes
  /// a numerical value and corresponding [TitleMeta] metadata, and returns a styled
  /// [Text] widget representing the title.
  ///
  /// Parameters:
  /// - `value`: The numerical value for which the title is generated.
  /// - `titleMeta`: Metadata containing information about the axis side.
  ///
  /// Returns:
  /// - A [SideTitleWidget] containing the styled [Text] representing the title.
  Widget getTitles(double value, TitleMeta titleMeta) {
    final Widget text = Text(
      days[value.toInt()], // Retrieve the day from the 'days' list
      style: const TextStyle(
        color: Color(0xff7589a2), // Set text color
        fontWeight: FontWeight.bold, // Use bold font weight
        fontSize: 14, // Set font size
      ),
    );

    // Create a SideTitleWidget with specified axis side, space, and the text widget.
    return SideTitleWidget(axisSide: titleMeta.axisSide, space: 4, child: text);
  }

  /// Generates a list of [LineChartBarData] based on the spots list and colors.
  ///
  /// This function creates a [LineChartBarData] for each set of spots in the
  /// spots list. The color for each bar is determined by the corresponding color
  /// from the colors list. The other properties of the bar data, such as curvature,
  /// bar width, stroke cap, and dots, are set accordingly.
  ///
  /// Returns:
  /// - A list of [LineChartBarData] representing the bars to be displayed in the
  ///   line chart.
  List<LineChartBarData> generateLineBarsData() {
    return List.generate(
      widget.spotsList.length,
      (index) => LineChartBarData(
        isCurved: true, // Set to true for curved lines
        color: colors[index], // Assign color from the colors list
        barWidth: 4, // Set the width of each bar
        isStrokeCapRound: true, // Use rounded stroke caps
        dotData: FlDotData(show: false), // Do not display dots on the line
        belowBarData: BarAreaData(show: false), // Do not show below bar area
        spots: widget.spotsList[index], // Set the spots for the line chart
      ),
    );
  }

  /// Gets the color associated with a given title in the line chart.
  ///
  /// This function looks up the index of the provided title in the list of
  /// titles from the widget's titles. If found, it returns the corresponding
  /// color from the colors list; otherwise, it returns the default color black.
  ///
  /// Parameters:
  /// - `title`: A string representing the title for which to fetch the color.
  ///
  /// Returns:
  /// - A [Color] representing the color associated with the given title.
  Color getColorForTitle(String title) {
    // Find the index of the provided title in the list of titles
    int index = widget.titles.toList().indexOf(title);

    // Check if the title is found and the index is within the valid range of colors
    if (index != -1 && index < colors.length) {
      // Return the color associated with the title
      return colors[index];
    }

    // Return the default color (black) if title is not found or index is out of range
    return Colors.black;
  }
}
