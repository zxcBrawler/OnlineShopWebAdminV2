import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/table/basic_text_column_headers.dart';

List<DataColumn> generateColumns(List<String> titles) {
  return titles.map((title) {
    return DataColumn(
      label: BasicTextColumnHeaders(
        title: title,
      ),
    );
  }).toList();
}
