import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/chart/basic_pie_chart.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_state.dart';

class AdminTotalUsers extends StatefulWidget {
  const AdminTotalUsers({super.key});

  @override
  State<AdminTotalUsers> createState() => _AdminTotalUsersState();
}

class _AdminTotalUsersState extends State<AdminTotalUsers> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteUserBloc>(
      create: (context) => service()..add(const GetUsers()),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            child: Column(
              children: [
                BlocBuilder<RemoteUserBloc, RemoteUserState>(
                  builder: (_, state) {
                    switch (state.runtimeType) {
                      case RemoteUserLoading:
                        return const Center(child: CircularProgressIndicator());
                      case RemoteUserDone:
                        List<String> roles = state.users!
                            .map((user) => user.role!.roleName!)
                            .toList();
                        Map<String, double> roleCounts = {};
                        for (var role in roles) {
                          roleCounts[role] = (roleCounts[role] ?? 0) + 1;
                        }
                        return Column(
                          children: [
                            BasicText(
                              title: 'total users: ${state.users?.length}',
                            ),
                            BasicPieChart(inputData: roleCounts)
                          ],
                        );

                      case RemoteUserError:
                        return const Text("error");
                    }
                    return const SizedBox();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            router.go(Pages.adminAllUsers.screenPath);
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            size: 35,
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
