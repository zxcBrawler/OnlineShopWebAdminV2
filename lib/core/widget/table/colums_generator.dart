import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/table/basic_text_column_headers.dart';

/// Generates a list of [DataColumn] widgets based on the provided titles.
///
/// This function takes a list of [String] titles and generates a [DataColumn]
/// widget for each title. Each [DataColumn] is labeled with a [BasicTextColumnHeaders]
/// widget containing the corresponding title.
///
/// Parameters:
/// - `titles`: A list of [String] titles representing the column headers.
///
/// Returns:
/// - A list of [DataColumn] widgets representing the generated columns.
List<DataColumn> generateColumns(List<String> titles) {
  return titles.map((title) {
    return DataColumn(
      label: BasicTextColumnHeaders(
        title: title,
      ),
    );
  }).toList();
}
