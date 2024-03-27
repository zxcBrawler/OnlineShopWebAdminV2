import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/pdf_service.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/core/widget/text/card_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';

class ClothesTable extends StatefulWidget {
  final String? title;
  const ClothesTable({super.key, this.title});

  @override
  State<ClothesTable> createState() => _ClothesTableState();
}

class _ClothesTableState extends State<ClothesTable> {
  String _searchQuery = ''; // Store the search query

  /// Builds the widget tree based on the provided [RemoteClothesBloc] state.
  ///
  /// This method builds a [BlocBuilder] widget that listens to the state
  /// of [RemoteClothesBloc]. Depending on the state, it renders different
  /// widgets.
  ///
  /// The method takes a [BuildContext] as a parameter, which is used to build
  /// the widget tree.
  ///
  /// Returns a [Widget] tree that represents the built UI.
  @override
  Widget build(BuildContext context) {
    List<ClothesEntity> clothes = [];
    // Build the widget tree based on the state of RemoteClothesBloc
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search bar

        BasicSearchBar(
          onChangedCallback: (value) {
            setState(() {
              _searchQuery =
                  value?.toLowerCase() ?? ''; // Update the search query
            });
          },
        ),

        Row(
          children: [
            const CardText(title: "generate pdf"),
            SizedBox(
                height: 70,
                width: 70,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicContainer(
                      child: IconButton(
                        onPressed: () {
                          PdfService().printsClothesPDF(clothes);
                        },
                        icon: const Icon(Icons.description),
                      ),
                    ))),
          ],
        ),

        const SizedBox(
            height: 10), // Add some space between the search bar and the table
        // BlocBuilder for RemoteClothesBloc
        BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
          builder: (_, state) {
            // Depending on the state, render different widgets
            switch (state.runtimeType) {
              // If the state is RemoteClothesLoading, render a progress indicator
              case RemoteClothesLoading:
                return const Center(child: CircularProgressIndicator());
              // If the state is RemoteClothesDone, render a table with clothes data
              case RemoteClothesDone:

                // Filter clothes based on the title provided and the search query
                switch (widget.title) {
                  case "male clothes":
                    clothes = state.clothes!
                        .where((element) =>
                            element.typeClothes!.categoryClothes!
                                    .nameCategory ==
                                "male" &&
                            element.nameClothesEn!
                                .toLowerCase()
                                .contains(_searchQuery))
                        .toList();
                    break;
                  case "female clothes":
                    clothes = state.clothes!
                        .where((element) =>
                            element.typeClothes!.categoryClothes!
                                    .nameCategory ==
                                "female" &&
                            element.nameClothesEn!
                                .toLowerCase()
                                .contains(_searchQuery))
                        .toList();
                    break;
                  case "clothes":
                    clothes = state.clothes!
                        .where((element) => element.nameClothesEn!
                            .toLowerCase()
                            .contains(_searchQuery))
                        .toList();
                    break;
                }
                // Generate columns for the table based on the first clothes entity
                return BasicTable(
                  columns:
                      generateColumns(state.clothes!.first.getProperties()),
                  dataSource: BasicDataSource<ClothesEntity>(
                    rowsCount: clothes.length,
                    columnTitles: state.clothes!.first.getProperties(),
                    data: clothes,
                  ),
                );
              // If the state is RemoteClothesError, render an error text
              case RemoteClothesError:
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
