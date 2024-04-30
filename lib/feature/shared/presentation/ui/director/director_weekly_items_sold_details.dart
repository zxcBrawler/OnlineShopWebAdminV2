import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_weekly_sold_items_by_week.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class DirectorWeeklyItemsSoldDetails extends StatefulWidget {
  const DirectorWeeklyItemsSoldDetails({super.key});

  @override
  State<DirectorWeeklyItemsSoldDetails> createState() =>
      _DirectorWeeklyItemsSoldDetailsState();
}

class _DirectorWeeklyItemsSoldDetailsState
    extends State<DirectorWeeklyItemsSoldDetails> {
  @override
  Widget build(BuildContext context) {
    late List<DeliveryInfoEntity> allShopOrders;
    final isMobile = Responsive.isMobile(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header widget
            Row(
              children: [
                Expanded(
                  child: Header(
                    title: S.current.itemsSoldOverview,
                  ),
                ),
              ],
            ),
            // Line chart

            // Search bar and filters

            const Row(
              children: [DirectorWeeklySoldItemsByWeek()],
            ),
            // Active users table
            Row(
              // A horizontally expanding widget that contains a table widget
              children: [
                Expanded(
                    // Expands to fill available horizontal space
                    child: BlocProvider<RemoteDeliveryInfoBloc>(
                  create: (context) => service()..add(const GetDeliveryInfo()),
                  child: BlocBuilder<RemoteDeliveryInfoBloc,
                      RemoteDeliveryInfoState>(
                    builder: (_, state) {
                      switch (state.runtimeType) {
                        case RemoteDeliveryInfoLoading:
                          return const Center(
                              child: CircularProgressIndicator());
                        case RemoteDeliveryInfoDone:
                          allShopOrders = state.info!
                              .where(
                                (element) =>
                                    element.shopAddresses!.shopAddressId
                                        .toString() ==
                                    SessionStorage.getValue("shopAddressId"),
                              )
                              .toList();
                          return BlocProvider<RemoteOrderCompBloc>(
                            create: (context) =>
                                service()..add(const GetOrderComp()),
                            child: Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, top: 20, left: 8, right: 8),
                                child: Column(
                                  children: [
                                    BlocBuilder<RemoteOrderCompBloc,
                                        RemoteOrderCompState>(
                                      builder: (_, state) {
                                        switch (state.runtimeType) {
                                          case RemoteOrderCompLoading:
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          case RemoteOrderCompDone:
                                            List<OrderCompositionEntity>
                                                compositions =
                                                state.compositions!
                                                    .where(
                                                      (composition) =>
                                                          allShopOrders
                                                              .any((order) =>
                                                                  order.order!
                                                                      .idOrder! ==
                                                                  composition
                                                                      .orderId!
                                                                      .idOrder),
                                                    )
                                                    .toList();

                                            return Methods
                                                .buildWeeklyOrdersCompositions(
                                                    state,
                                                    isMobile,
                                                    compositions);
                                          case RemoteOrderCompError:
                                            return Text(S.current.error);
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                        case RemoteDeliveryInfoError:
                          return Text(S.current.error);
                      }
                      return const SizedBox();
                    },
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
