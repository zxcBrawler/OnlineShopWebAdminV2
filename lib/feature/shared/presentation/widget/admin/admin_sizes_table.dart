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
        BlocBuilder<RemoteSizeBloc, RemoteSizeState>(
          builder: (_, state) {
            switch (state.runtimeType) {
              case RemoteSizesLoading:
                return const Center(child: CircularProgressIndicator());

              case RemoteSizesDone:
                final List<SizeClothesEntity> allSizes = state.sizes!
                    .where((element) =>
                        element.nameSize!.toLowerCase().contains(_searchQuery))
                    .toList();
                return BasicTable(
                  columns: generateColumns(state.sizes!.first.getProperties()),
                  dataSource: BasicDataSource<SizeClothesEntity>(
                    rowsCount: allSizes.length,
                    columnTitles: state.sizes!.first.getProperties(),
                    data: allSizes,
                  ),
                );

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
