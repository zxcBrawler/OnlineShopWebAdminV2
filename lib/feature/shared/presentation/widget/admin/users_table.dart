import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_state.dart';

class UsersTable extends StatefulWidget {
  const UsersTable({super.key});

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  String _searchQuery = ''; // Store the search query
  @override

  /// Builds the widget tree based on the state of the [RemoteUserBloc].
  ///
  /// Wraps the widget with [BlocBuilder] to listen for changes in the state
  /// of [RemoteUserBloc]. The [BlocBuilder] builds the widget tree based on
  /// the runtime type of the state.
  Widget build(BuildContext context) {
    // Build the widget tree based on the state of the RemoteUserBloc
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BasicSearchBar(
          onChangedCallback: (value) {
            setState(() {
              _searchQuery =
                  value?.toLowerCase() ?? ''; // Update the search query
            });
          },
        ),
        BlocProvider<RemoteUserBloc>(
          create: (context) => service()..add(const GetUsers()),
          child: BlocBuilder<RemoteUserBloc, RemoteUserState>(
            // Builder method to render the widget based on the state of RemoteUserBloc
            builder: (_, state) {
              // Switch on the runtime type of the state to handle different cases
              switch (state.runtimeType) {
                // Case when the state is of type RemoteUserLoading
                case RemoteUserLoading:
                  // Show loading indicator while fetching data
                  return const Center(child: CircularProgressIndicator());
                // Case when the state is of type RemoteUserDone
                case RemoteUserDone:
                  // Retrieve the properties of the first user in the list
                  final List<String> columnTitles =
                      state.users!.first.getProperties();
                  final List<UserEntity> allUsers = state.users!
                      .where((element) => element.username!
                          .toLowerCase()
                          .contains(_searchQuery))
                      .toList();
                  // Build the BasicTable widget with the generated columns and data
                  return BasicTable(
                    columns: generateColumns(columnTitles),
                    dataSource: BasicDataSource<UserEntity>(
                      rowsCount: allUsers.length,
                      columnTitles: columnTitles,
                      data: allUsers,
                    ),
                  );
                // Case when the state is of type RemoteUserError
                case RemoteUserError:
                  // Display error message
                  return const Text("error");
              }
              // Return an empty sized box as the default case
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
