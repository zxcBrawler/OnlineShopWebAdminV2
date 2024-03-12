import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/other/indicator.dart';

class BasicPieChart extends StatefulWidget {
  // Input data for the pie chart, mapping titles to values
  final Map<String, double> inputData;

  const BasicPieChart({super.key, required this.inputData});

  @override
  State<BasicPieChart> createState() => _BasicPieChartState();
}

class _BasicPieChartState extends State<BasicPieChart> {
  // Index of the selected section in the pie chart
  int? selectedSectionIndex;

  // List of colors for each section in the pie chart
  late List<Color> colors;

  @override
  void initState() {
    super.initState();
    // Generate random colors for each section
    colors = List.generate(
      widget.inputData.values.length,
      (index) =>
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// SizedBox containing a PieChart widget.
        ///
        /// This widget represents a sized box with a fixed height of 300 containing a
        /// PieChart. The PieChart is configured with PieChartData, and its sections and
        /// their properties are generated using the [generatePieChartSections] function.
        /// The pieTouchData enables touch interactions on the chart, and the selected
        /// section index is updated based on touch events.
        ///
        /// Returns:
        /// - A [SizedBox] containing a [PieChart] widget.
        SizedBox(
          height: 300,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0, // Set space between sections
              centerSpaceRadius:
                  double.infinity, // Make the center of the chart transparent
              sections: generatePieChartSections(
                widget.inputData.values.toList(),
                widget.inputData.keys.toList(),
              ),
              pieTouchData: PieTouchData(
                enabled: true, // Enable touch interactions
                touchCallback: _handlePieChartTouch,
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 18,
        ),
        // Display indicators with titles for each section in the pie chart
        /// Row widget containing indicators for each entry in inputData.
        ///
        /// This widget represents a horizontal row of indicators, where each indicator
        /// corresponds to an entry in the inputData. The indicators are created using
        /// the Indicator widget, and their colors are determined by the [getColorForTitle]
        /// function. The row is centered using MainAxisAlignment.center.
        ///
        /// Returns:
        /// - A [Row] widget containing indicators for each entry in inputData.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 15.0, // Adjust the spacing between indicators
                    runSpacing: 8.0, // Adjust the spacing between rows
                    children: widget.inputData.keys.map((title) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Indicator(
                          color: getColorForTitle(title),
                          text: title,
                          isSquare: false,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Generates a list of [PieChartSectionData] based on input values and titles.
  ///
  /// This function creates a pie chart section data for each value, determining
  /// the appearance of each section based on its index and whether it is selected.
  ///
  /// Parameters:
  /// - `values`: A list of double values representing the data values for each section.
  /// - `titles`: A list of strings representing titles for each section.
  ///
  /// Returns:
  /// - A list of [PieChartSectionData] representing the sections of the pie chart.
  List<PieChartSectionData> generatePieChartSections(
      List<double> values, List<String> titles) {
    return List.generate(
      values.length,
      (index) {
        // Check if the current section is selected
        final isSelected = selectedSectionIndex == index;

        // Create a PieChartSectionData with properties based on selection
        return PieChartSectionData(
          color: colors[index], // Color for the section
          value: values[index], // Value of the section
          radius: isSelected ? 70 : 60, // Radius based on selection
          title: isSelected
              ? values[index].toString()
              : null, // Title based on selection
          titleStyle: isSelected
              ? const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
              : const TextStyle(color: Colors.transparent),
        );
      },
    );
  }

  // Get color for a specific title
  /// Gets the color associated with a given title in the pie chart.
  ///
  /// This function looks up the index of the provided title in the list of
  /// titles from the widget's inputData. If found, it returns the corresponding
  /// color from the colors list; otherwise, it returns the default color black.
  ///
  /// Parameters:
  /// - `title`: A string representing the title for which to fetch the color.
  ///
  /// Returns:
  /// - A [Color] representing the color associated with the given title.
  Color getColorForTitle(String title) {
    // Find the index of the provided title in the list of titles
    int index = widget.inputData.keys.toList().indexOf(title);

    // Check if the title is found and the index is within the valid range of colors
    if (index != -1 && index < colors.length) {
      // Return the color associated with the title
      return colors[index];
    }

    // Return the default color (black) if title is not found or index is out of range
    return Colors.black;
  }

  /// Touch callback function for PieChart interaction.
  ///
  /// This callback function is used to handle touch events on the PieChart. It
  /// updates the selected section index based on the touch events. If the touch
  /// event is not interested for interactions, or the pieTouchResponse or touched
  /// section is null, the selectedSectionIndex is set to -1. Otherwise, it is set
  /// to the touched section index.
  ///
  /// Parameters:
  /// - [event]: The FlTouchEvent containing touch event information.
  /// - [pieTouchResponse]: The response from the PieChart regarding touch events.
  void _handlePieChartTouch(FlTouchEvent event, dynamic pieTouchResponse) {
    setState(() {
      // Update the selected section index based on touch events
      if (!event.isInterestedForInteractions ||
          pieTouchResponse == null ||
          pieTouchResponse.touchedSection == null) {
        selectedSectionIndex = -1; // No touched section, set index to -1
        return;
      }
      selectedSectionIndex = pieTouchResponse
          .touchedSection!.touchedSectionIndex; // Set index to touched section
    });
  }
}
