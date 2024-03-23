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
  Widget build(BuildContext context) {
    return BlocProvider<RemoteOrderCompBloc>(
      create: (context) => service()..add(const GetOrderComp()),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            child: Column(
              children: [
                BlocBuilder<RemoteOrderCompBloc, RemoteOrderCompState>(
                  builder: (_, state) {
                    switch (state.runtimeType) {
                      case RemoteOrderCompLoading:
                        return const Center(child: CircularProgressIndicator());
                      case RemoteOrderCompDone:
                        List<OrderCompositionEntity> compositions =
                            state.compositions!;
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
                          children: [
                            BasicText(title: Methods.displayCurrentWeek()),
                            BasicBarChart(
                                barsList: [flSpotListMale, flSpotListFemale]),
                          ],
                        );

                      case RemoteOrderCompError:
                        return const Text("error");
                    }
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
