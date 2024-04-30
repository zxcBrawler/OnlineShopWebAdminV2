import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/chart/basic_line_chart.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class DirectorWeeklyOrdersByWeek extends StatefulWidget {
  const DirectorWeeklyOrdersByWeek({super.key});

  @override
  State<DirectorWeeklyOrdersByWeek> createState() =>
      _DirectorWeeklyOrdersByWeekState();
}

class _DirectorWeeklyOrdersByWeekState
    extends State<DirectorWeeklyOrdersByWeek> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteDeliveryInfoBloc>(
      create: (context) => service()..add(const GetDeliveryInfo()),
      // Use BlocBuilder to rebuild the widget based on the state of RemoteDeliveryInfoBloc
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            child: Column(
              children: [
                BlocBuilder<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
                  builder: (_, state) {
                    // Check the type of state and build the UI accordingly
                    switch (state.runtimeType) {
                      case RemoteDeliveryInfoLoading:
                        // Display a loading indicator if the data is still loading
                        return const Center(child: CircularProgressIndicator());
                      case RemoteDeliveryInfoDone:
                        // Generate FlSpot lists for Pick Up and Delivery types
                        List<FlSpot> flSpotListPickUp =
                            Methods.generateFlSpotList(
                          state.info!
                              .where((element) =>
                                  element.shopAddresses!.shopAddressId
                                      .toString() ==
                                  SessionStorage.getValue("shopAddressId"))
                              .toList(),
                          typeDeliveryId: 1,
                        );

                        // Display a BasicLineChart with the generated FlSpot lists
                        return Column(
                          children: [
                            BasicText(title: Methods.displayCurrentWeek()),
                            BasicLineChart(
                              spotsList: [flSpotListPickUp],
                              titles: [S.current.pickUp],
                            ),
                          ],
                        );

                      case RemoteDeliveryInfoError:
                        // Display an error message if there is an error in fetching the data
                        return Text(S.current.error);
                    }

                    // Return an empty SizedBox by default
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
