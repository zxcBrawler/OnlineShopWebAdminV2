import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/di/service.dart';

import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_state.dart';

class EmployeesTable extends StatefulWidget {
  const EmployeesTable({super.key});

  @override
  State<EmployeesTable> createState() => _EmployeesTableState();
}

class _EmployeesTableState extends State<EmployeesTable> {
  String _searchQuery = ''; // Store the search query

  @override
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
        BlocProvider<RemoteEmployeeShopBloc>(
          create: (context) => service()
            ..add(GetAllEmployeesByShopId(
                shopId: int.parse(SessionStorage.getValue("shopAddressId")))),
          child: BlocBuilder<RemoteEmployeeShopBloc, RemoteEmployeeShopState>(
            builder: (_, state) {
              switch (state.runtimeType) {
                case RemoteEmployeeShopLoading:
                  return const Center(child: CircularProgressIndicator());

                case RemoteAllEmployeesByShopIdDone:
                  final List<String> columnTitles =
                      state.users!.first.employee!.getProperties();

                  // Extract UserEntity objects from EmployeeShopEntity instances
                  final List<UserEntity> users = state.users!
                      .map((employee) => employee.employee!)
                      .toList();

                  // Filter the list of users based on the search query
                  final List<UserEntity> filteredUsers = users
                      .where((user) =>
                          user.username!.toLowerCase().contains(_searchQuery))
                      .toList();

                  return BasicTable(
                    columns: generateColumns(columnTitles),
                    dataSource: BasicDataSource<UserEntity>(
                      rowsCount: filteredUsers.length,
                      columnTitles: columnTitles,
                      data: filteredUsers,
                    ),
                  );

                case RemoteEmployeeShopError:
                  // Display error message
                  return const Text("error");
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
