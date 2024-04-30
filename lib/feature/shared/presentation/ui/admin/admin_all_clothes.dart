import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_add_clothes_dialog.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_clothes_table.dart';

class AdminAllClothes extends StatefulWidget {
  final String? title;
  const AdminAllClothes({super.key, this.title});

  @override
  State<AdminAllClothes> createState() => _AdminAllClothesState();
}

class _AdminAllClothesState extends State<AdminAllClothes> {
  @override

  /// Builds the widget tree for the [AdminAllClothes] screen.
  ///
  /// This method is called when the widget is inserted into the widget tree.
  /// It returns a [SafeArea] widget that contains a [SingleChildScrollView]
  /// widget with padding. The [SingleChildScrollView] contains a [Column]
  /// widget with multiple [Row] widgets, each containing various children.
  ///
  /// The [Column] widget starts with a [Header] widget containing the title
  /// passed to the widget. Then, it contains a [Row] widget with two children.
  /// The first child is a [BasicSearchBar] widget, and the second child is
  /// another [Row] widget. This second [Row] widget contains two children,
  /// each containing an [IconButton] widget. The first [IconButton] triggers
  /// a dialog to be shown, and the second [IconButton] does nothing.
  ///
  /// After that, the [Column] widget contains another [Row] widget, which
  /// contains a [BasicContainer] widget containing a [ClothesTable] widget.
  /// The [ClothesTable] widget is wrapped in a [BlocProvider] widget.
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
                    title: '${widget.title}',
                  ),
                ),
              ],
            ),
            Row(
              // A horizontally expanding widget that contains search bar and filter buttons
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // Spaces out the children horizontally
              children: [
                Expanded(
                  // Expands to fill available horizontal space
                  child: Row(
                    // A horizontally expanding widget that contains two filter buttons
                    mainAxisAlignment: MainAxisAlignment.end,
                    // Aligns the children to the right
                    children: [
                      SizedBox(
                          height: 70,
                          width: 70,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BasicContainer(
                                child: IconButton(
                                  onPressed: () {
                                    // Open add user dialog
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AddClothesDialog();
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
                            child: BlocProvider<RemoteClothesBloc>(
                              create: (context) =>
                                  service()..add(const GetClothes()),
                              child: ClothesTable(
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
