import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/chart/basic_pie_chart.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class EmployeeMaleItemsWidget extends StatefulWidget {
  const EmployeeMaleItemsWidget({super.key});

  @override
  State<EmployeeMaleItemsWidget> createState() =>
      _EmployeeMaleItemsWidgetState();
}

class _EmployeeMaleItemsWidgetState extends State<EmployeeMaleItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteShopGarnishBloc>(
      create: (context) => service()
        ..add(GetShopGarnish(
            id: int.parse(SessionStorage.getValue("shopAddressId")))),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            child: Column(
              children: [
                BlocBuilder<RemoteShopGarnishBloc, RemoteShopGarnishState>(
                  builder: (_, state) {
                    switch (state.runtimeType) {
                      case RemoteShopGarnishLoading:
                        return const Center(child: CircularProgressIndicator());
                      case RemoteShopGarnishDone:
                        List<String> clothesTypes = state.shopGarnish!
                            .where((element) =>
                                element
                                    .sizeClothesGarnish!
                                    .clothes!
                                    .typeClothes!
                                    .categoryClothes!
                                    .nameCategory ==
                                'female')
                            .map((clothes) => clothes.sizeClothesGarnish!
                                .clothes!.typeClothes!.nameType!)
                            .toList();
                        Map<String, double> clothesCount = {};
                        for (var type in clothesTypes) {
                          clothesCount[type] = (clothesCount[type] ?? 0) + 1;
                        }
                        int quantity = 0;
                        for (var item in state.shopGarnish!) {
                          if (item.sizeClothesGarnish!.clothes!.typeClothes!
                                  .categoryClothes!.nameCategory ==
                              "male") {
                            quantity += item.quantity!;
                          }
                        }
                        return Column(
                          children: [
                            BasicText(
                              title:
                                  '${S.of(context).totalMaleClothes}: $quantity',
                            ),
                            BasicPieChart(inputData: clothesCount)
                          ],
                        );

                      case RemoteShopGarnishError:
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
                          onPressed: () {
                            router.go(
                              Pages.employeeAllMaleClothes.screenPath,
                            );
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
