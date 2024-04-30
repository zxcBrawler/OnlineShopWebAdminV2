import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/shop_garnish_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class DirectorClothesTable extends StatefulWidget {
  final String? title;
  const DirectorClothesTable({super.key, this.title});

  @override
  State<DirectorClothesTable> createState() => _DirectorClothesTableState();
}

class _DirectorClothesTableState extends State<DirectorClothesTable> {
  String _searchQuery = ''; // Store the search query
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BasicSearchBar(
          onChangedCallback: (value) {
            setState(() {
              _searchQuery = value?.toLowerCase() ?? '';
            });
          },
        ),
        BlocBuilder<RemoteShopGarnishBloc, RemoteShopGarnishState>(
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
                  case "male clothes" || "мужская одежда":
                    clothes = state.shopGarnish!
                        .where((element) =>
                            element.sizeClothesGarnish!.clothes!.typeClothes!
                                    .categoryClothes!.nameCategory ==
                                "male" &&
                            element.sizeClothesGarnish!.clothes!.nameClothesEn!
                                .toLowerCase()
                                .contains(_searchQuery))
                        .toList();
                    break;
                  case "female clothes" || "женская одежда":
                    clothes = state.shopGarnish!
                        .where((element) =>
                            element.sizeClothesGarnish!.clothes!.typeClothes!
                                    .categoryClothes!.nameCategory ==
                                "female" &&
                            element.sizeClothesGarnish!.clothes!.nameClothesEn!
                                .toLowerCase()
                                .contains(_searchQuery))
                        .toList();
                    break;
                  case "clothes" || "все товары":
                    clothes = state.shopGarnish!
                        .where((element) => element
                            .sizeClothesGarnish!.clothes!.nameClothesEn!
                            .toLowerCase()
                            .contains(_searchQuery))
                        .toList();
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
                return Text(S.current.error);
            }
            // If none of the states match, return an empty sized box
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
