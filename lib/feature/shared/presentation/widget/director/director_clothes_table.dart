import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_garnish_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_state.dart';

class DirectorClothesTable extends StatefulWidget {
  final String? title;
  const DirectorClothesTable({super.key, this.title});

  @override
  State<DirectorClothesTable> createState() => _DirectorClothesTableState();
}

class _DirectorClothesTableState extends State<DirectorClothesTable> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteShopGarnishBloc, RemoteShopGarnishState>(
      builder: (_, state) {
        // Depending on the state, render different widgets
        switch (state.runtimeType) {
          // If the state is RemoteClothesLoading, render a progress indicator
          case RemoteShopGarnishLoading:
            return const Center(child: CircularProgressIndicator());
          // If the state is RemoteClothesDone, render a table with clothes data
          case RemoteShopGarnishDone:
            List<ShopGarnishEntity> clothes = [];
            // Filter clothes based on the title provided
            switch (widget.title) {
              case "male clothes":
                clothes = state.shopGarnish!
                    .where((element) =>
                        element.sizeClothesGarnish!.clothes!.typeClothes!
                            .categoryClothes!.nameCategory ==
                        "male")
                    .toList();
                break;
              case "female clothes":
                clothes = state.shopGarnish!
                    .where((element) =>
                        element.sizeClothesGarnish!.clothes!.typeClothes!
                            .categoryClothes!.nameCategory ==
                        "female")
                    .toList();
                break;
              case "clothes":
                clothes = state.shopGarnish!;
                break;
            }
            // Generate columns for the table based on the first clothes entity
            return BasicTable(
              columns:
                  generateColumns(state.shopGarnish!.first.getProperties()),
              dataSource: BasicDataSource<ShopGarnishEntity>(
                rowsCount: clothes.length,
                columnTitles: state.shopGarnish!.first.getProperties(),
                data: clothes,
              ),
            );
          // If the state is RemoteClothesError, render an error text
          case RemoteShopGarnishError:
            return const Text("error");
        }
        // If none of the states match, return an empty sized box
        return const SizedBox();
      },
    );
  }
}
