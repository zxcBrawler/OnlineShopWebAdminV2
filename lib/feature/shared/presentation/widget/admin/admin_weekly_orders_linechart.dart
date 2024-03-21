import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/widget/chart/basic_line_chart.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';

/// Widget representing the admin view of weekly orders, including a line chart
class AdminWeeklyOrdersLinechart extends StatefulWidget {
  const AdminWeeklyOrdersLinechart({Key? key}) : super(key: key);

  @override
  State<AdminWeeklyOrdersLinechart> createState() =>
      _AdminWeeklyOrdersLinechartState();
}

class _AdminWeeklyOrdersLinechartState
    extends State<AdminWeeklyOrdersLinechart> {
  @override
  Widget build(BuildContext context) {
    // Provide the RemoteDeliveryInfoBloc to the widget tree
    return BlocProvider<RemoteDeliveryInfoBloc>(
      create: (context) => service()..add(const GetDeliveryInfo()),
      // Use BlocBuilder to rebuild the widget based on the state of RemoteDeliveryInfoBloc
      child: BlocBuilder<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
        builder: (_, state) {
          // Check the type of state and build the UI accordingly
          switch (state.runtimeType) {
            case RemoteDeliveryInfoLoading:
              // Display a loading indicator if the data is still loading
              return const Center(child: CircularProgressIndicator());
            case RemoteDeliveryInfoDone:
              // Generate FlSpot lists for Pick Up and Delivery types
              List<FlSpot> flSpotListPickUp = Methods.generateFlSpotList(
                state.info!,
                typeDeliveryId: 1,
              );

              List<FlSpot> flSpotListDelivery = Methods.generateFlSpotList(
                state.info!,
                typeDeliveryId: 2,
              );

              // Display a BasicLineChart with the generated FlSpot lists
              return BasicLineChart(
                spotsList: [flSpotListPickUp, flSpotListDelivery],
                titles: const ["Pick up", "Delivery"],
              );

            case RemoteDeliveryInfoError:
              // Display an error message if there is an error in fetching the data
              return const Text("error");
          }

          // Return an empty SizedBox by default
          return const SizedBox();
        },
      ),
    );
  }
}
