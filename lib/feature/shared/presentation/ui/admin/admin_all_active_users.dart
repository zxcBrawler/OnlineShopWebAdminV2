import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/users_table.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';

class AllActiveUsers extends StatefulWidget {
  const AllActiveUsers({super.key});

  @override
  State<AllActiveUsers> createState() => _AllActiveUsersState();
}

class _AllActiveUsersState extends State<AllActiveUsers> {
  @override

  /// Builds the user interface widget tree for this state.
  ///
  /// The [context] parameter is the build context for this widget.
  ///
  /// Returns a scrollable area that contains a column of widgets. The column
  /// contains a header, a row of search bar and filter buttons, and a table of
  /// active users.
  Widget build(BuildContext context) {
    // Build the UI widget tree.
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Build the header.
            _buildHeader(),
            // Build the row of search bar and filter buttons.
            _buildSearchBarAndFilterButtons(),
            // Build the table of active users.
            _buildUsersTable(),
          ],
        ),
      ),
    );
  }

  /// Builds the header for the UI.
  ///
  /// Returns a row containing a single expanded widget with a [Header] child.
  Widget _buildHeader() {
    return const Row(
      children: [
        Expanded(
          child: Header(
            title: 'all active users',
          ),
        ),
      ],
    );
  }

  /// Builds the row of search bar and filter buttons for the UI.
  ///
  /// Returns a row containing a [BasicSearchBar] widget and an expanded widget
  /// containing a row of filter buttons.
  Widget _buildSearchBarAndFilterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const BasicSearchBar(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Build the filter buttons.
              _buildFilterButtons(),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the filter buttons for the UI.
  ///
  /// Returns a row containing three filter buttons.
  Widget _buildFilterButtons() {
    return Row(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BasicContainer(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 70,
          width: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BasicContainer(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 70,
          width: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BasicContainer(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the table of active users for the UI.
  ///
  /// Returns a row containing a single expanded widget with a [UsersTable]
  /// child.
  Widget _buildUsersTable() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: BasicContainer(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Expanded(
                      child: UsersTable(),
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
