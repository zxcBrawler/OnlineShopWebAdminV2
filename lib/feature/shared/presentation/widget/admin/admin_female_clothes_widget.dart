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

class FemaleClothesWidget extends StatefulWidget {
  const FemaleClothesWidget({super.key});

  @override
  State<FemaleClothesWidget> createState() => _FemaleClothesWidgetState();
}

class _FemaleClothesWidgetState extends State<FemaleClothesWidget> {
  @override

  /// Builds the female clothes widget.
  ///
  /// This function builds the female clothes widget which displays the
  /// number of female clothes and a pie chart of the female clothes types.
  /// It also provides a button to navigate to the [AdminAllClothesScreen].
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
                        // Get the list of clothes types for female clothes.
                        List<String> clothesTypes = state.clothes!
                            .where((element) =>
                                element.typeClothes!.categoryClothes!
                                    .nameCategory ==
                                'female')
                            .map((clothes) => clothes.typeClothes!.nameType!)
                            .toList();
                        // Count the number of occurences of each clothes type.
                        Map<String, double> clothesCount = {};
                        for (var type in clothesTypes) {
                          clothesCount[type] = (clothesCount[type] ?? 0) + 1;
                        }
                        return Column(
                          children: [
                            // Display the total number of female clothes.
                            BasicText(
                              title:
                                  'total female clothes: ${clothesTypes.length}',
                            ),
                            // Display a pie chart of the female clothes types.
                            BasicPieChart(inputData: clothesCount)
                          ],
                        );

                      case RemoteClothesError:
                        // Display an error message if there is an error fetching
                        // the clothes.
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
                      // Build an IconButton that navigates to the
                      // [AdminAllClothesScreen].
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
