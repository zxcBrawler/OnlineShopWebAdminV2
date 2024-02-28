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
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: PaginatedDataTable(
                arrowHeadColor: AppColors.black,
                source: widget.dataSource,
                columns: [
                  ...widget.columns, // Your existing columns
                  const DataColumn(
                    label: BasicTextColumnHeaders(
                      title: 'Actions',
                    ),
                  ),
                ],
                columnSpacing: 50,
                horizontalMargin: 10,
                rowsPerPage: 10,
                showCheckboxColumn: false,
                headingRowHeight: 60,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
