import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
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
  @override
  Widget build(BuildContext context) {
    // Build the widget tree based on the state of the RemoteUserBloc
    return BlocProvider<RemoteEmployeeShopBloc>(
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

              return BasicTable(
                columns: generateColumns(columnTitles),
                dataSource: BasicDataSource<UserEntity>(
                  rowsCount: state.users!.length,
                  columnTitles: columnTitles,
                  data: state.users!.map((e) => e.employee!).toList(),
                ),
              );

            case RemoteEmployeeShopError:
              // Display error message
              return const Text("error");
          }

          return const SizedBox();
        },
      ),
    );
  }
}
