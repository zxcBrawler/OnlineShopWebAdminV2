import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/widget/chart/basic_bar_chart.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_state.dart';

class AdminWeeklySoldItemsByWeek extends StatefulWidget {
  const AdminWeeklySoldItemsByWeek({super.key});

  @override
  State<AdminWeeklySoldItemsByWeek> createState() =>
      _AdminWeeklySoldItemsByWeekState();
}

class _AdminWeeklySoldItemsByWeekState
    extends State<AdminWeeklySoldItemsByWeek> {
  @override

  /// Builds the UI for the [AdminWeeklySoldItemsByWeek] widget.
  ///
  /// This widget uses the BlocProvider to provide the [RemoteOrderCompBloc] to
  /// its children. It also uses the BlocBuilder to listen to the state changes
  /// of the [RemoteOrderCompBloc] and build the UI accordingly.
  Widget build(BuildContext context) {
    // Wraps the widget with BlocProvider to provide the RemoteOrderCompBloc
    return BlocProvider<RemoteOrderCompBloc>(
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

                        // Displays the current week and the bar chart
                        return Column(
                          children: [
                            BasicText(title: Methods.displayCurrentWeek()),
                            BasicBarChart(
                                barsList: [flSpotListMale, flSpotListFemale]),
                          ],
                        );
                      // When the state is RemoteOrderCompError, displays error text
                      case RemoteOrderCompError:
                        return const Text("error");
                    }
                    // Returns SizedBox when the state is not handled
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
