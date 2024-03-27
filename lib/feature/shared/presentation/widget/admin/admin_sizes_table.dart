import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_state.dart';

class SizesTable extends StatefulWidget {
  const SizesTable({super.key});

  @override
  State<SizesTable> createState() => _SizesTableState();
}

class _SizesTableState extends State<SizesTable> {
  String _searchQuery = ''; // Store the search query
  @override

  /// Builds the UI for the SizesTable widget.
  ///
  /// This function creates a column widget that consists of a search bar and a
  /// table. The search bar allows the user to search for a specific size.
  /// The table displays the sizes that match the search query.
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Create a search bar to allow the user to search for a specific size
        BasicSearchBar(
          onChangedCallback: (value) {
            setState(() {
              _searchQuery =
                  value?.toLowerCase() ?? ''; // Update the search query
            });
          },
        ),
        // Use BlocBuilder to listen to changes in the RemoteSizeBloc state
        BlocBuilder<RemoteSizeBloc, RemoteSizeState>(
          builder: (_, state) {
            // Handle the different states of the RemoteSizeBloc
            switch (state.runtimeType) {
              // If the state is RemoteSizesLoading, show a loading indicator
              case RemoteSizesLoading:
                return const Center(child: CircularProgressIndicator());

              // If the state is RemoteSizesDone, show the table with the matching sizes
              case RemoteSizesDone:
                // Filter the sizes based on the search query
                final List<SizeClothesEntity> allSizes = state.sizes!
                    .where((element) =>
                        element.nameSize!.toLowerCase().contains(_searchQuery))
                    .toList();
                // Create a BasicTable widget with the filtered sizes
                return BasicTable(
                  columns: generateColumns(state.sizes!.first.getProperties()),
                  dataSource: BasicDataSource<SizeClothesEntity>(
                    rowsCount: allSizes.length,
                    columnTitles: state.sizes!.first.getProperties(),
                    data: allSizes,
                  ),
                );

              // If the state is RemoteSizesError, show an error message
              case RemoteSizesError:
                return const Text("error");
            }
            // If none of the states match, return an empty sized box
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
