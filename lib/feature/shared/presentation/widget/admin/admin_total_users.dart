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
import 'package:xc_web_admin/generated/l10n.dart';

class AdminTotalUsers extends StatefulWidget {
  const AdminTotalUsers({super.key});

  @override
  State<AdminTotalUsers> createState() => _AdminTotalUsersState();
}

class _AdminTotalUsersState extends State<AdminTotalUsers> {
  @override

  /// Builds the widget tree for the [AdminTotalUsers] widget.
  ///
  /// This method uses the `BlocProvider` widget to provide an instance of
  /// `RemoteUserBloc` to its children. It also uses the `Expanded` widget to
  /// make the widget take up all the available vertical space.
  ///
  /// The widget tree consists of a `BasicContainer` widget that contains a
  /// `Column` widget. Inside the column, there is a `BlocBuilder` widget that
  /// listens to changes in the state of the `RemoteUserBloc`. Depending on
  /// the current state, it renders different widgets.
  ///
  /// If the state is of type `RemoteUserLoading`, it renders a
  /// `CircularProgressIndicator` widget. If the state is of type
  /// `RemoteUserDone`, it renders a `Column` widget that contains a
  /// `BasicText` widget displaying the total number of users and a
  /// `BasicPieChart` widget displaying the distribution of roles among the
  /// users. If the state is of type `RemoteUserError`, it renders a `Text`
  /// widget displaying the error message.
  ///
  /// At the end of the column, there is a `Row` widget that contains an
  /// `IconButton` widget. This button, when pressed, navigates to the
  /// `adminAllUsers` screen.
  Widget build(BuildContext context) {
    return BlocProvider<RemoteUserBloc>(
      create: (context) => service()..add(const GetUsers()),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            child: Column(
              children: [
                // Listens to changes in the state of the RemoteUserBloc and
                // renders different widgets based on the current state.
                BlocBuilder<RemoteUserBloc, RemoteUserState>(
                  builder: (_, state) {
                    // Depending on the current state, renders different widgets.
                    switch (state.runtimeType) {
                      case RemoteUserLoading:
                        // Renders a CircularProgressIndicator widget when the
                        // state is RemoteUserLoading.
                        return const Center(child: CircularProgressIndicator());
                      case RemoteUserDone:
                        // Renders a Column widget when the state is
                        // RemoteUserDone.
                        List<String> roles = state.users!
                            .map((user) => user.role!.roleName!)
                            .toList();
                        Map<String, double> roleCounts = {};
                        for (var role in roles) {
                          roleCounts[role] = (roleCounts[role] ?? 0) + 1;
                        }
                        return Column(
                          children: [
                            // Renders a BasicText widget displaying the total
                            // number of users.
                            BasicText(
                              title:
                                  '${S.of(context).totalUsers}: ${state.users?.length}',
                            ),
                            // Renders a BasicPieChart widget displaying the
                            // distribution of roles among the users.
                            BasicPieChart(inputData: roleCounts)
                          ],
                        );

                      case RemoteUserError:
                        // Renders a Text widget displaying the error message
                        // when the state is RemoteUserError.
                        return Text(S.of(context).error);
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
                            // Navigates to the adminAllUsers screen when the
                            // button is pressed.
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
