import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/chart/basic_bar_chart.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class AdminWeeklyItemsSold extends StatelessWidget {
  const AdminWeeklyItemsSold({super.key});

  @override

  /// Builds the UI for the [AdminWeeklyItemsSold] widget.
  ///
  /// This widget uses the BlocProvider to provide the [RemoteOrderCompBloc] to
  /// its children. It also uses the BlocBuilder to listen to the state changes
  /// of the [RemoteOrderCompBloc] and build the UI accordingly.
  Widget build(BuildContext context) {
    return BlocProvider<RemoteOrderCompBloc>(
      // Provides the RemoteOrderCompBloc to its children
      create: (context) => service()..add(const GetOrderComp()),
      // Wraps the widget with Expanded to take up all the available space
      child: Expanded(
        // Applies padding to the child widget
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          // Wraps the child widget with BasicContainer
          child: BasicContainer(
            // Builds the Column widget with children
            child: Column(
              children: [
                // Uses BlocBuilder to listen to the state changes of RemoteOrderCompBloc
                BlocBuilder<RemoteOrderCompBloc, RemoteOrderCompState>(
                  // Builds the UI according to the state
                  builder: (_, state) {
                    // Checks the runtime type of the state
                    switch (state.runtimeType) {
                      // When the state is RemoteOrderCompLoading, displays CircularProgressIndicator
                      case RemoteOrderCompLoading:
                        return const Center(child: CircularProgressIndicator());
                      // When the state is RemoteOrderCompDone, displays the weekly sold items chart
                      case RemoteOrderCompDone:
                        // Retrieves the compositions from the state
                        List<OrderCompositionEntity> compositions =
                            state.compositions!;
                        // Generates the bar chart data for male and female
                        List<BarChartRodData> flSpotListMale =
                            Methods.generateFlSpotListForOrdersComp(
                          compositions,
                          genderId: 1,
                        );
                        List<BarChartRodData> flSpotListFemale =
                            Methods.generateFlSpotListForOrdersComp(
                          compositions,
                          genderId: 2,
                        );
                        return Column(
                          // Displays the weekly items sold overview and the bar chart
                          children: [
                            BasicText(
                                title: S.of(context).weeklyItemsSoldOverview),
                            BasicBarChart(
                                barsList: [flSpotListMale, flSpotListFemale]),
                          ],
                        );
                      // When the state is RemoteOrderCompError, displays "error" text
                      case RemoteOrderCompError:
                        return Text(S.of(context).error);
                    }
                    // Returns an empty SizedBox when the state is not handled
                    return const SizedBox();
                  },
                ),
                // Builds the Row widget with an IconButton
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // Navigates to the adminWeeklyItemsSoldDetails screen
                            router.go(
                              Pages.adminWeeklyItemsSoldDetails.screenPath,
                            );
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
