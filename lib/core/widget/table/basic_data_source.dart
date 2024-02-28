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

  /// Gets the data row at the specified [index].
  /// Returns a [DataRow] for the specified [index].
  ///
  /// If [index] is within the valid range of [rowsCount], it generates regular
  /// data cells based on the [columnTitles] and [rowData]. Additionally, a
  /// permanent column is added to the data row for actions/icons.
  ///
  /// Returns `null` if [index] is out of range.
  @override
  DataRow? getRow(int index) {
    if (index < rowsCount) {
      final rowData = data[index];
      final regularCells = List<DataCell>.generate(
        columnTitles.length,
        (cellIndex) {
          final cellValue =
              (rowData as dynamic).getPropertyValue(columnTitles[cellIndex]);

          return DataCell(
            BasicTextColumnData(
              title: '$cellValue',
            ),
          );
        },
      );

      // returns permanent column at the end of each row containit two Icon buttons to delete and edit
      final permanentColumn = DataCell(TableIcons(
        // Extracting the type of data stored in table from the data's string representation
        type: data.first.toString().split('\'')[1],
        data: data[index],
      ));

      return DataRow(
        cells: [...regularCells, permanentColumn],
      );
    }
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
