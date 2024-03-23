import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_add_clothes_dialog.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_clothes_table.dart';

import '../../../../../di/service.dart';

class DirectorAllClothes extends StatefulWidget {
  final String? title;
  const DirectorAllClothes({super.key, this.title});

  @override
  State<DirectorAllClothes> createState() => _DirectorAllClothesState();
}

class _DirectorAllClothesState extends State<DirectorAllClothes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wraps the screen in a safe area
      child: SingleChildScrollView(
        // A scrollable widget that contains the rest of the widgets
        padding: const EdgeInsets.all(16.0),
        // Padding around the widgets
        child: Column(
          // A vertically expanding widget that contains the rest of the widgets
          children: [
            Row(
              // A horizontally expanding widget that contains a header widget
              children: [
                Expanded(
                  // Expands to fill available horizontal space
                  child: Header(
                    // A widget for displaying a title
                    title: 'all ${widget.title}',
                  ),
                ),
              ],
            ),
            Row(
              // A horizontally expanding widget that contains search bar and filter buttons
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // Spaces out the children horizontally
              children: [
                const BasicSearchBar(),
                // A widget for searching
                Expanded(
                  // Expands to fill available horizontal space
                  child: Row(
                    // A horizontally expanding widget that contains two filter buttons
                    mainAxisAlignment: MainAxisAlignment.end,
                    // Aligns the children to the right
                    children: [
                      SizedBox(
                          // A sized box for the filter button
                          height: 70,
                          width: 70,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BasicContainer(
                                // A container for the filter button
                                child: IconButton(
                                  onPressed: () {},
                                  // What happens when the filter button is pressed
                                  icon: const Icon(Icons.filter_alt),
                                ),
                              ))),
                      SizedBox(
                          height: 70,
                          width: 70,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BasicContainer(
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const DirectorAddClothesDialog();
                                        });
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ))),
                    ],
                  ),
                )
              ],
            ),
            Row(
              // A horizontally expanding widget that contains a table widget
              children: [
                Expanded(
                  // Expands to fill available horizontal space
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicContainer(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocProvider<RemoteShopGarnishBloc>(
                              create: (context) => service()
                                ..add(GetShopGarnish(
                                    id: int.parse(SessionStorage.getValue(
                                        "shopAddressId")))),
                              child: DirectorClothesTable(
                                title: widget.title,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}