import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/users_table.dart';

class AdminAllUsers extends StatefulWidget {
  const AdminAllUsers({super.key});

  @override
  State<AdminAllUsers> createState() => _AdminAllUsersState();
}

class _AdminAllUsersState extends State<AdminAllUsers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  child: Header(
                    title: 'all users',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const BasicSearchBar(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                              ))),
                      SizedBox(
                          height: 70,
                          width: 70,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BasicContainer(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add),
                                ),
                              ))),
                    ],
                  ),
                )
              ],
            ),
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
                              create: (context) =>
                                  service()..add(const GetUsers()),
                              child: const UsersTable(),
                            ), //implement linechart
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
