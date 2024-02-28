import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';
import 'package:xc_web_admin/core/widget/chart/basic_line_chart.dart';

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
              List<FlSpot> flSpotListPickUp = generateFlSpotList(
                state.info!,
                typeDeliveryId: 1,
              );

              List<FlSpot> flSpotListDelivery = generateFlSpotList(
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

  /// Generates a list of FlSpot objects representing occurrences for each day
  /// of the week based on the given [deliveryInfoList] and [typeDeliveryId].
  ///
  /// The function filters the [deliveryInfoList] based on the provided
  /// [typeDeliveryId] and considers only the dates within the current week.
  ///
  /// Returns a list of FlSpot objects where the x-axis represents the day of the
  /// week (0 to 6, where 0 is Monday and 6 is Sunday), and the y-axis represents
  /// the occurrences for each corresponding day.
  List<FlSpot> generateFlSpotList(List<DeliveryInfoEntity> deliveryInfoList,
      {required int typeDeliveryId}) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Filter and map deliveryInfoList to get DateTime objects within the current week
    List<DateTime> dateTimeList = deliveryInfoList
        .where((info) =>
            info.typeDelivery!.id == typeDeliveryId &&
            DateTime.parse(info.order!.dateOrder!).isAfter(
              currentDate.subtract(
                Duration(days: currentDate.weekday),
              ),
            ))
        .map((info) => DateTime.parse(info.order!.dateOrder!))
        .toList();

    // Generate FlSpot objects for each day of the week
    return List.generate(7, (index) {
      // Calculate occurrences for the current day (1 to 7)
      int occurrences = dateTimeList
          .where((dateTime) => dateTime.weekday == (index + 1))
          .length;

      // Return FlSpot object with x-axis representing the day and
      // y-axis representing the occurrences
      return FlSpot(index.toDouble(), occurrences.toDouble());
    });
  }
}
