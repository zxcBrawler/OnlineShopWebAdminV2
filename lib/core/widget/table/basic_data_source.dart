import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/table/basic_text_column_data.dart';
import 'package:xc_web_admin/core/widget/table/table_icons.dart';

/// A basic implementation of [DataTableSource] to provide data for a [DataTable].
/// Data source is used to generate the data table rows and cells.
class BasicDataSource<T> extends DataTableSource {
  /// The total number of rows in the data source.
  final int rowsCount;

  /// List of column titles to define the structure of the data table.
  final List<String> columnTitles;

  /// List of data objects to populate the data table.
  final List<T> data;

  /// Constructor to create a [BasicDataSource].
  BasicDataSource({
    required this.rowsCount,
    required this.columnTitles,
    required this.data,
  });

  @override

  /// Gets the data row at the specified [index].
  ///
  /// If [index] is within the valid range of [rowsCount], it generates regular
  /// data cells based on the [columnTitles] and [rowData]. Additionally, a
  /// permanent column is added to the data row for actions/icons.
  ///
  /// Returns `null` if [index] is out of range.
  ///
  DataRow? getRow(int index) {
    // Check if the index is within the valid range of rowsCount
    if (index < rowsCount) {
      // Get the row data at the specified index
      final rowData = data[index];

      // Generate regular cells for each column in the row data
      final regularCells = List<DataCell>.generate(
        columnTitles.length,
        (cellIndex) {
          // Get the value of the cell at the specified index in the row data
          final cellValue =
              (rowData as dynamic).getPropertyValue(columnTitles[cellIndex]);

          // Create a BasicTextColumnData widget with the cell value as its title
          return DataCell(
            BasicTextColumnData(
              title: '$cellValue',
            ),
          );
        },
      );

      // Create a TableIcons widget with the type of data stored in the table
      // and the row data as its parameters
      final permanentColumn = DataCell(TableIcons(
        type: data.first.toString().split('\'')[1],
        data: data[index],
      ));

      // Create a DataRow with the regular cells and the permanent column
      return DataRow(
        cells: [...regularCells, permanentColumn],
      );
    }

    // Return null if the index is out of range
    return null;
  }

  /// Indicates whether the row count is approximate.
  @override
  bool get isRowCountApproximate => false;

  /// The number of selected rows.
  @override
  int get selectedRowCount => 0;

  /// The total number of rows in the data source.
  @override
  int get rowCount => rowsCount;
}
