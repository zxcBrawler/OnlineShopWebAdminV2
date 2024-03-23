import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_add_color_dialog.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_colors_table.dart';

class AdminAllColors extends StatefulWidget {
  const AdminAllColors({super.key});

  @override
  State<AdminAllColors> createState() => _AdminAllColorsState();
}

class _AdminAllColorsState extends State<AdminAllColors> {
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
            const Row(
              // A horizontally expanding widget that contains a header widget
              children: [
                Expanded(
                  // Expands to fill available horizontal space
                  child: Header(
                    // A widget for displaying a title
                    title: 'all colors',
                  ),
                ),
              ],
            ),
            Row(
              // A horizontally expanding widget that contains search bar and filter buttons
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // Spaces out the children horizontally
              children: [
                // A widget for searching
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
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AddColorDialog();
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
                            child: BlocProvider<RemoteColorBloc>(
                              create: (context) =>
                                  service()..add(const GetColors()),
                              child: const ColorsTable(),
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
