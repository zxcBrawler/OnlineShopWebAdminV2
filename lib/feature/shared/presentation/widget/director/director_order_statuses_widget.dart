import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/chart/basic_pie_chart.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class DirectorOrderStatuses extends StatefulWidget {
  const DirectorOrderStatuses({super.key});

  @override
  State<DirectorOrderStatuses> createState() => _DirectorOrderStatusesState();
}

class _DirectorOrderStatusesState extends State<DirectorOrderStatuses> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteDeliveryInfoBloc>(
      create: (context) => service()..add(const GetDeliveryInfo()),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            child: Column(
              children: [
                BlocBuilder<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
                  builder: (_, state) {
                    switch (state.runtimeType) {
                      case RemoteDeliveryInfoLoading:
                        return const Center(child: CircularProgressIndicator());
                      case RemoteDeliveryInfoDone:
                        List<DeliveryInfoEntity> shopOrders = state.info!
                            .where(
                              (element) =>
                                  element.shopAddresses!.shopAddressId
                                      .toString() ==
                                  SessionStorage.getValue("shopAddressId"),
                            )
                            .toList();
                        List<String> statuses = shopOrders
                            .map((element) =>
                                element.order!.currentStatus!.nameStatus!)
                            .toList();
                        Map<String, double> statusCount = {};
                        for (var type in statuses) {
                          statusCount[type] = (statusCount[type] ?? 0) + 1;
                        }
                        return Column(
                          children: [
                            BasicText(
                              title: S.current.ordersByStatus,
                            ),
                            BasicPieChart(inputData: statusCount)
                          ],
                        );

                      case RemoteDeliveryInfoError:
                        return Text(S.current.error);
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
