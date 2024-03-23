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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BasicSearchBar(
          onChangedCallback: (value) {
            setState(() {
              _searchQuery =
                  value?.toLowerCase() ?? ''; // Update the search query
            });
          },
        ),
        BlocBuilder<RemoteColorBloc, RemoteColorState>(
          builder: (_, state) {
            switch (state.runtimeType) {
              case RemoteColorsLoading:
                return const Center(child: CircularProgressIndicator());

              case RemoteColorsDone:
                final List<ColorEntity> allColors = state.colors!
                    .where((element) =>
                        element.nameColor!.toLowerCase().contains(_searchQuery))
                    .toList();
                return BasicTable(
                  columns: generateColumns(state.colors!.first.getProperties()),
                  dataSource: BasicDataSource<ColorEntity>(
                    rowsCount: allColors.length,
                    columnTitles: state.colors!.first.getProperties(),
                    data: allColors,
                  ),
                );

              case RemoteColorsError:
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
