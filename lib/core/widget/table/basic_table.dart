import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/widget/table/basic_text_column_headers.dart';

// A Universal widget that displays a table with a given set of columns and data source
// Takes each data type of the data source as a parameter
class BasicTable extends StatefulWidget {
  final List<DataColumn> columns;
  final DataTableSource dataSource;
  const BasicTable({
    super.key,
    required this.columns,
    required this.dataSource,
  });

  @override
  State<BasicTable> createState() => BasicTableState();
}

class BasicTableState extends State<BasicTable> {
  @override

  /// Builds the [BasicTable] widget.
  ///
  /// This method builds the [BasicTable] widget. It returns a [Row] widget
  /// containing a [SingleChildScrollView] widget with a [PaginatedDataTable]
  /// widget. The [PaginatedDataTable] widget is configured with the provided
  /// [widget.columns] and [widget.dataSource] as the data source. It also
  /// includes an additional column for 'Actions' and sets various properties
  /// such as [columnSpacing], [horizontalMargin], [rowsPerPage], [showCheckboxColumn],
  /// and [headingRowHeight].
  ///
  /// Parameters:
  /// - `context`: The [BuildContext] of the widget.
  ///
  /// Returns:
  /// - A [Row] widget containing a [SingleChildScrollView] widget with a
  /// [PaginatedDataTable] widget.
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Expanded widget that contains a SingleChildScrollView widget
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // SizedBox widget with the width set to the width of the screen
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: PaginatedDataTable(
                arrowHeadColor: AppColors.black, // Color of the arrow
                source: widget.dataSource, // Data source for the table
                columns: [
                  ...widget.columns, // Existing columns for the table
                  const DataColumn(
                    // Additional column for 'Actions'
                    label: BasicTextColumnHeaders(
                      title: 'Actions', // Title for the column
                    ),
                  ),
                ],
                columnSpacing: 50, // Spacing between columns
                horizontalMargin: 10, // Horizontal margin of the table
                rowsPerPage: 10, // Number of rows per page
                showCheckboxColumn: false, // Hide checkbox column
                headingRowHeight: 60, // Height of the heading row
              ),
            ),
          ),
        ),
      ],
    );
  }
}
