import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/director/director_weekly_orders_by_week.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class EmployeeWeeklyOrdersDetails extends StatefulWidget {
  const EmployeeWeeklyOrdersDetails({super.key});

  @override
  State<EmployeeWeeklyOrdersDetails> createState() =>
      _EmployeeWeeklyOrdersDetailsState();
}

class _EmployeeWeeklyOrdersDetailsState
    extends State<EmployeeWeeklyOrdersDetails> {
  @override
  Widget build(BuildContext context) {
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
                    title: S.current.ordersOverview,
                  ),
                ),
              ],
            ),
            // Line chart

            // Search bar and filters

            const Row(
              children: [DirectorWeeklyOrdersByWeek()],
            ),
            // Active users table
            Row(
              // A horizontally expanding widget that contains a table widget
              children: [
                Expanded(
                  // Expands to fill available horizontal space
                  child: BlocProvider<RemoteDeliveryInfoBloc>(
                    create: (context) =>
                        service()..add(const GetDeliveryInfo()),
                    child: BlocBuilder<RemoteDeliveryInfoBloc,
                        RemoteDeliveryInfoState>(
                      builder: (_, state) {
                        switch (state.runtimeType) {
                          case RemoteDeliveryInfoLoading:
                            return const Center(
                                child: CircularProgressIndicator());
                          case RemoteDeliveryInfoDone:
                            List<DeliveryInfoEntity> shopOrders = state.info!
                                .where((element) =>
                                    element.shopAddresses!.shopAddressId
                                        .toString() ==
                                    SessionStorage.getValue("shopAddressId"))
                                .toList();
                            return Methods.buildWeeklyOrders(
                                state, isMobile, shopOrders);

                          case RemoteDeliveryInfoError:
                            return const Text("error");
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
