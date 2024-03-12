import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteSizeBloc, RemoteSizeState>(
      builder: (_, state) {
        switch (state.runtimeType) {
          case RemoteSizesLoading:
            return const Center(child: CircularProgressIndicator());

          case RemoteSizesDone:
            return BasicTable(
              columns: generateColumns(state.sizes!.first.getProperties()),
              dataSource: BasicDataSource<SizeClothesEntity>(
                rowsCount: state.sizes!.length,
                columnTitles: state.sizes!.first.getProperties(),
                data: state.sizes!,
              ),
            );

          case RemoteSizesError:
            return const Text("error");
        }
        // If none of the states match, return an empty sized box
        return const SizedBox();
      },
    );
  }
}
