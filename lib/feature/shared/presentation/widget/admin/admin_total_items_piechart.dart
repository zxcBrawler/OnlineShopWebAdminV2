import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/chart/basic_pie_chart.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';

class AdminTotalItemsPiechart extends StatefulWidget {
  const AdminTotalItemsPiechart({super.key});

  @override
  State<AdminTotalItemsPiechart> createState() =>
      _AdminTotalItemsPiechartState();
}

class _AdminTotalItemsPiechartState extends State<AdminTotalItemsPiechart> {
  @override

  /// Builds the stateful widget.
  ///
  /// This widget builds a stateful widget that displays the total number
  /// of clothes and a pie chart of the clothes types. It also provides a
  /// button to navigate to the [AdminAllClothesScreen].
  Widget build(BuildContext context) {
    // Wrap the widget with a BlocProvider to provide a [RemoteClothesBloc]
    // instance to its descendants.
    return BlocProvider<RemoteClothesBloc>(
      create: (context) => service()..add(const GetClothes()),
      // Set the child widget which will be wrapped with the BlocProvider.
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          // Wrap the child widget with a BasicContainer widget.
          child: BasicContainer(
            child: Column(
              children: [
                // Build a BlocBuilder to listen to changes in the state of the
                // [RemoteClothesBloc].
                BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
                  builder: (_, state) {
                    // Handle the different possible states of the
                    // [RemoteClothesBloc].
                    switch (state.runtimeType) {
                      case RemoteClothesLoading:
                        // Display a circular progress indicator while the
                        // clothes are being fetched.
                        return const Center(child: CircularProgressIndicator());
                      case RemoteClothesDone:
                        // Get the list of clothes types.
                        List<String> clothesTypes = state.clothes!
                            .map((clothes) => clothes.typeClothes!.nameType!)
                            .toList();
                        // Count the number of occurences of each clothes type.
                        Map<String, double> clothesCount = {};
                        for (var type in clothesTypes) {
                          clothesCount[type] = (clothesCount[type] ?? 0) + 1;
                        }
                        return Column(
                          children: [
                            // Display the total number of clothes.
                            BasicText(
                              title: 'total clothes: ${clothesTypes.length}',
                            ),
                            // Display a pie chart of the clothes types.
                            BasicPieChart(inputData: clothesCount)
                          ],
                        );

                      case RemoteClothesError:
                        return const Text("error");
                    }
                    return const SizedBox();
                  },
                ),
                // Add a button to navigate to the [AdminAllClothesScreen].
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            router.go(Pages.adminAllClothes.screenPath,
                                extra: {"clothes"});
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
