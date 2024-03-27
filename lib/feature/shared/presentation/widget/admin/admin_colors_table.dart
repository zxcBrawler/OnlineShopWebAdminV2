import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_state.dart';

class ColorsTable extends StatefulWidget {
  const ColorsTable({super.key});

  @override
  State<ColorsTable> createState() => _ColorsTableState();
}

class _ColorsTableState extends State<ColorsTable> {
  String _searchQuery = ''; // Store the search query
  @override

  /// Builds the colors table widget.
  ///
  /// This function builds a column widget containing a search bar and a
  /// table widget. The search bar allows the user to filter the colors based
  /// on their name. The table widget displays the filtered colors.
  ///
  /// The [context] parameter is the build context of the widget.
  ///
  /// Returns a column widget.
  Widget build(BuildContext context) {
    // Column widget to contain the search bar and the table widget
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search bar widget to filter colors
        BasicSearchBar(
          // Callback function to update the search query
          onChangedCallback: (value) {
            setState(() {
              _searchQuery =
                  value?.toLowerCase() ?? ''; // Update the search query
            });
          },
        ),
        // BlocBuilder widget to listen to the state of the color bloc
        BlocBuilder<RemoteColorBloc, RemoteColorState>(
          // Callback function to build the widget based on the state
          builder: (_, state) {
            // Switch statement to handle different states of the color bloc
            switch (state.runtimeType) {
              // Case for when the colors are in loading state
              case RemoteColorsLoading:
                // Return a centered progress indicator widget
                return const Center(child: CircularProgressIndicator());

              // Case for when the colors are loaded successfully
              case RemoteColorsDone:
                // Filter the colors based on the search query
                final List<ColorEntity> allColors = state.colors!
                    .where((element) =>
                        element.nameColor!.toLowerCase().contains(_searchQuery))
                    .toList();
                // Return a table widget containing the filtered colors
                return BasicTable(
                  // Generate the columns for the table
                  columns: generateColumns(state.colors!.first.getProperties()),
                  // Data source for the table containing the filtered colors
                  dataSource: BasicDataSource<ColorEntity>(
                    rowsCount: allColors.length,
                    columnTitles: state.colors!.first.getProperties(),
                    data: allColors,
                  ),
                );

              // Case for when there is an error in the color bloc
              case RemoteColorsError:
                // Return a text widget displaying "error"
                return const Text("error");
            }
            // If none of the states match, return an empty sized box widget
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
