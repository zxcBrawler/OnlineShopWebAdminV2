import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_clothes_table.dart';

class EmployeeAllClothes extends StatefulWidget {
  final String? title;
  const EmployeeAllClothes({super.key, this.title});

  @override
  State<EmployeeAllClothes> createState() => _EmployeeAllClothesState();
}

class _EmployeeAllClothesState extends State<EmployeeAllClothes> {
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
