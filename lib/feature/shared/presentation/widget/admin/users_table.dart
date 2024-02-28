import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_state.dart';

class UsersTable extends StatefulWidget {
  const UsersTable({super.key});

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteUserBloc, RemoteUserState>(
      listener: (context, state) {
        print("123");
      },
      builder: (context, state) {
        return BlocBuilder<RemoteUserBloc, RemoteUserState>(
          builder: (_, state) {
            switch (state.runtimeType) {
              case RemoteUserLoading:
                return const Center(child: CircularProgressIndicator());
              case RemoteUserDone:
                final List<String> columnTitles =
                    state.users!.first.getProperties();
                return BasicTable(
                  columns: generateColumns(columnTitles),
                  dataSource: BasicDataSource<UserEntity>(
                    rowsCount: state.users!.length,
                    columnTitles: columnTitles,
                    data: state.users!,
                  ),
                );
              case RemoteUserError:
                return const Text("error");
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
