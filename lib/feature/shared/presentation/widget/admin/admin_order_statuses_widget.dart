import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/chart/basic_pie_chart.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';

class AdminOrderStatuses extends StatefulWidget {
  const AdminOrderStatuses({super.key});

  @override
  State<AdminOrderStatuses> createState() => _AdminOrderStatusesState();
}

class _AdminOrderStatusesState extends State<AdminOrderStatuses> {
  @override

  /// Builds the widget tree for the [AdminOrderStatusesWidget].
  ///
  /// Wraps the widget with [BlocProvider] to provide the [RemoteDeliveryInfoBloc].
  /// Creates an instance of [RemoteDeliveryInfoBloc] using the [service] method.
  /// Listens for changes in the state of [RemoteDeliveryInfoBloc] using [BlocBuilder].
  /// Returns the widget tree based on the runtime type of the state.
  Widget build(BuildContext context) {
    // Wrap the widget with BlocProvider to provide the RemoteDeliveryInfoBloc
    return BlocProvider<RemoteDeliveryInfoBloc>(
      create: (context) => service()..add(const GetDeliveryInfo()),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            child: Column(
              children: [
                // Listen for changes in the state of RemoteDeliveryInfoBloc
                BlocBuilder<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
                  builder: (_, state) {
                    // Based on the runtime type of the state, return the appropriate widget
                    switch (state.runtimeType) {
                      // If the state is of type RemoteDeliveryInfoLoading, show a circular progress indicator
                      case RemoteDeliveryInfoLoading:
                        return const Center(child: CircularProgressIndicator());
                      // If the state is of type RemoteDeliveryInfoDone, show the pie chart widget
                      case RemoteDeliveryInfoDone:
                        List<String> statuses = state.info!
                            .map((element) =>
                                element.order!.currentStatus!.nameStatus!)
                            .toList();
                        Map<String, double> statusCount = {};
                        for (var type in statuses) {
                          statusCount[type] = (statusCount[type] ?? 0) + 1;
                        }
                        return Column(
                          children: [
                            const BasicText(
                              title: 'orders by status',
                            ),
                            BasicPieChart(inputData: statusCount),
                          ],
                        );

                      // If the state is of type RemoteDeliveryInfoError, show a text widget
                      case RemoteDeliveryInfoError:
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.chevron_right,
                            size: 35,
                            color: Colors.transparent,
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
