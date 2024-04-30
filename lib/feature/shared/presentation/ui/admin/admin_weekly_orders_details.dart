import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_weekly_orders_by_week.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class AdminWeeklyOrdersDetails extends StatefulWidget {
  const AdminWeeklyOrdersDetails({super.key});

  @override
  State<AdminWeeklyOrdersDetails> createState() =>
      _AdminWeeklyOrdersDetailsState();
}

class _AdminWeeklyOrdersDetailsState extends State<AdminWeeklyOrdersDetails> {
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
                    title: S.of(context).ordersOverview,
                  ),
                ),
              ],
            ),
            // Line chart

            // Search bar and filters

            const Row(
              children: [AdminWeeklyOrdersByWeek()],
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
                            return Methods.buildWeeklyOrders(
                                state, isMobile, state.info!);

                          case RemoteDeliveryInfoError:
                            return Text(S.of(context).error);
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
