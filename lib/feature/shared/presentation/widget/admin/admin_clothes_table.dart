import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
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
  @override

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
    // Build the widget tree based on the state of RemoteClothesBloc
    return BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
      builder: (_, state) {
        // Depending on the state, render different widgets
        switch (state.runtimeType) {
          // If the state is RemoteClothesLoading, render a progress indicator
          case RemoteClothesLoading:
            return const Center(child: CircularProgressIndicator());
          // If the state is RemoteClothesDone, render a table with clothes data
          case RemoteClothesDone:
            List<ClothesEntity> clothes = [];
            // Filter clothes based on the title provided
            switch (widget.title) {
              case "male clothes":
                clothes = state.clothes!
                    .where((element) =>
                        element.typeClothes!.categoryClothes!.nameCategory ==
                        "male")
                    .toList();
                break;
              case "female clothes":
                clothes = state.clothes!
                    .where((element) =>
                        element.typeClothes!.categoryClothes!.nameCategory ==
                        "female")
                    .toList();
                break;
              case "clothes":
                clothes = state.clothes!;
                break;
            }
            // Generate columns for the table based on the first clothes entity
            return BasicTable(
              columns: generateColumns(state.clothes!.first.getProperties()),
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
    );
  }
}
