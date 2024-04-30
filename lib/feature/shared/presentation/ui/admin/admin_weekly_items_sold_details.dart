import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_clothes_weekly_items_by_week.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class AdminWeeklyItemsSoldDetails extends StatefulWidget {
  const AdminWeeklyItemsSoldDetails({super.key});

  @override
  State<AdminWeeklyItemsSoldDetails> createState() =>
      _AdminWeeklyItemsSoldDetailsState();
}

class _AdminWeeklyItemsSoldDetailsState
    extends State<AdminWeeklyItemsSoldDetails> {
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
                    title: S.of(context).itemsSoldOverview,
                  ),
                ),
              ],
            ),

            const Row(
              children: [AdminWeeklySoldItemsByWeek()],
            ),
            // Active users table
            Row(
              // A horizontally expanding widget that contains a table widget
              children: [
                Expanded(
                  // Expands to fill available horizontal space
                  child: BlocProvider<RemoteOrderCompBloc>(
                    create: (context) => service()..add(const GetOrderComp()),
                    child:
                        BlocBuilder<RemoteOrderCompBloc, RemoteOrderCompState>(
                      builder: (_, state) {
                        switch (state.runtimeType) {
                          case RemoteOrderCompLoading:
                            return const Center(
                                child: CircularProgressIndicator());
                          case RemoteOrderCompDone:
                            return Methods.buildWeeklyOrdersCompositions(
                                state, isMobile, state.compositions!);

                          case RemoteOrderCompError:
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
