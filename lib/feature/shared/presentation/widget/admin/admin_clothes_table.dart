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
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
      builder: (_, state) {
        switch (state.runtimeType) {
          case RemoteClothesLoading:
            return const Center(child: CircularProgressIndicator());
          case RemoteClothesDone:
            List<ClothesEntity> clothes = [];
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
            return BasicTable(
              columns: generateColumns(state.clothes!.first.getProperties()),
              dataSource: BasicDataSource<ClothesEntity>(
                rowsCount: clothes.length,
                columnTitles: state.clothes!.first.getProperties(),
                data: clothes,
              ),
            );
          case RemoteClothesError:
            return const Text("error");
        }
        return const SizedBox();
      },
    );
  }
}
