import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/chart/basic_pie_chart.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';

/// Widget representing the admin view of total orders, including a pie chart
/// showing the distribution of orders based on the type of delivery.
class AdminTotalOrders extends StatefulWidget {
  const AdminTotalOrders({super.key});

  @override
  State<AdminTotalOrders> createState() => _AdminTotalOrdersState();
}

class _AdminTotalOrdersState extends State<AdminTotalOrders> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteDeliveryInfoBloc>(
      // Provide the RemoteDeliveryInfoBloc using BlocProvider
      create: (context) => service()..add(const GetDeliveryInfo()),
      child: Expanded(
        // Expanded widget to fill available space
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            // BasicContainer for styling purposes
            child: Column(
              children: [
                BlocBuilder<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
                  builder: (_, state) {
                    switch (state.runtimeType) {
                      case RemoteDeliveryInfoLoading:
                        // Show loading indicator when data is still loading
                        return const Center(child: CircularProgressIndicator());
                      case RemoteDeliveryInfoDone:
                        // Extract the type of delivery for each order and count occurrences
                        List<String> typeDelivery = state.info!
                            .map((info) => info.typeDelivery!.nameType!)
                            .toList();

                        // Create a map to store the count of each type of delivery
                        Map<String, double> typeCounts = {};

                        // Iterate through the list and count occurrences of each type
                        for (var i in typeDelivery) {
                          typeCounts[i] = (typeCounts[i] ?? 0) + 1;
                        }

                        // Return a Column widget displaying total orders and a pie chart
                        // containing the distribution of orders
                        return Column(
                          children: [
                            BasicText(
                              // Display the total number of orders
                              title: 'total orders: ${state.info?.length}',
                            ),
                            BasicPieChart(inputData: typeCounts)
                          ],
                        );

                      case RemoteDeliveryInfoError:
                        // Show error message when there is an error fetching data
                        return const Text("error");
                    }
                    return const SizedBox();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Navigate to adminAllOrders page on right arrow button click
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          router.go(Pages.adminAllOrders.screenPath);
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          size: 35,
                        ),
                      ),
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
