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

class AdminWeeklyItemsSold extends StatelessWidget {
  const AdminWeeklyItemsSold({super.key});

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
                            const BasicText(
                                title: "weekly items sold overview"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            router.go(Pages.adminAllClothes.screenPath,
                                extra: {"female clothes"});
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
