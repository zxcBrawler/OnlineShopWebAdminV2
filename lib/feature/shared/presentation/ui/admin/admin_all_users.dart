import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_add_user_dialog.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/users_table.dart';

class AdminAllUsers extends StatefulWidget {
  const AdminAllUsers({super.key});

  @override
  State<AdminAllUsers> createState() => _AdminAllUsersState();
}

class _AdminAllUsersState extends State<AdminAllUsers> {
  @override

  /// Builds the UI for the [AdminAllUsers] widget.
  ///
  /// This method returns a [SafeArea] widget that contains a scrollable
  /// [SingleChildScrollView] with a column of widgets. The column contains
  /// a [Header] widget with the title 'all users', a [BasicSearchBar] widget,
  /// and a row with two [IconButton] widgets. The first [IconButton] opens a
  /// dialog box to filter the users, and the second [IconButton] opens a
  /// dialog box to add a new user. Below the row, there is another row with
  /// a [BasicContainer] widget that contains a [Column] widget with a
  /// [BlocProvider] widget that provides a [RemoteUserBloc] and a [UsersTable]
  /// widget.
  Widget build(BuildContext context) {
    return SafeArea(
      // Container that wraps the scrollable widget
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // Column of widgets
        child: Column(
          children: [
            // Header widget with title 'all users'
            const Row(
              children: [
                Expanded(
                  child: Header(
                    title: 'all users',
                  ),
                ),
              ],
            ),
            // Row with search bar and filter/add buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Add user button
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
                                          return const AddUserDialog();
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
            // Row with users table
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicContainer(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocProvider<RemoteUserBloc>(
                              // Provide RemoteUserBloc and get users
                              create: (context) =>
                                  service()..add(const GetUsers()),
                              child: const UsersTable(),
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
