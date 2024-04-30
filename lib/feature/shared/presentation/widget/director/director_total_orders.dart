import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class DirectorTotalOrders extends StatefulWidget {
  const DirectorTotalOrders({super.key});

  @override
  State<DirectorTotalOrders> createState() => _DirectorTotalOrdersState();
}

class _DirectorTotalOrdersState extends State<DirectorTotalOrders> {
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
                        List<DeliveryInfoEntity> shopOrders = state.info!
                            .where(
                              (element) =>
                                  element.shopAddresses!.shopAddressId
                                      .toString() ==
                                  SessionStorage.getValue("shopAddressId"),
                            )
                            .toList();

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BasicText(
                              // Display the total number of orders
                              title:
                                  '${S.current.totalOrders}: ${shopOrders.length}',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  SessionStorage.getValue('role') == 'employee'
                                      ? router.go(
                                          Pages.employeeAllOrders.screenPath)
                                      : router.go(
                                          Pages.directorAllOrders.screenPath);
                                },
                                icon: const Icon(
                                  Icons.chevron_right,
                                  size: 35,
                                ),
                              ),
                            )
                          ],
                        );

                      case RemoteDeliveryInfoError:
                        // Show error message when there is an error fetching data
                        return Text(S.current.error);
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
