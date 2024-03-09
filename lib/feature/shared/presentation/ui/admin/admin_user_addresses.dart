import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_shops_table.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';

class AdminUserAddresses extends StatefulWidget {
  const AdminUserAddresses({super.key});

  @override
  State<AdminUserAddresses> createState() => _AdminUserAddressesState();
}

class _AdminUserAddressesState extends State<AdminUserAddresses> {
  @override

  /// Builds the UI for the [AdminUserAddresses] widget.
  ///
  /// This method returns a [Row] widget that centers its children in the main
  /// axis. The children of the [Row] widget are an [Expanded] widget that
  /// contains a [Padding] widget. The [Padding] widget applies padding of 8.0
  /// to all sides of its child. The child of the [Padding] widget is a
  /// [BasicContainer] that contains a [Column] widget. The child of the
  /// [Column] widget is another [Padding] widget with padding of 8.0 to all
  /// sides. The child of the [Padding] widget is an [Expanded] widget that
  /// contains an [AdminShopsTable].
  ///
  /// This method is a constant constructor, which means that the instance of
  /// the widget will be the same every time it is called.
  @override
  Widget build(BuildContext context) {
    return const Row(
      // Center the children in the main axis.
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          // Expand the child to fill the available space.
          child: Padding(
            // Apply padding to the child widget.
            padding: EdgeInsets.all(8.0),
            child: BasicContainer(
              // The container for the user addresses UI.
              child: Column(
                // The column for the UI elements.
                children: [
                  Padding(
                    // Apply padding to the child widget.
                    padding: EdgeInsets.all(8.0),
                    child: Expanded(
                      // Expand the child to fill the available space.
                      child:
                          AdminShopsTable(), // Display the user addresses table.
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
