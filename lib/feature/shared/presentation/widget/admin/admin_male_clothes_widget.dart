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

class MaleClothesWidget extends StatefulWidget {
  const MaleClothesWidget({super.key});

  @override
  State<MaleClothesWidget> createState() => _MaleClothesWidgetState();
}

class _MaleClothesWidgetState extends State<MaleClothesWidget> {
  @override

  /// Builds the MaleClothesWidget.
  ///
  /// This method creates a [BlocProvider] with a [RemoteClothesBloc]
  /// that loads clothes data using the [GetClothes] event.
  /// It also creates a [Padding] widget with a [BasicContainer]
  /// that displays a pie chart and a text widget displaying the
  /// total number of male clothes.
  /// Finally, it creates a [Row] with an [IconButton]
  /// that navigates to the [adminAllClothes] page.
  ///
  /// The [context] parameter is required for building the
  /// [BlocProvider] and the [Padding] widget.
  Widget build(BuildContext context) {
    return BlocProvider<RemoteClothesBloc>(
      create: (context) => service()..add(const GetClothes()),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            child: Column(
              children: [
                // Builds a pie chart and a text widget based on the state of RemoteClothesBloc
                BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
                  builder: (_, state) {
                    // Display a circular progress indicator while loading
                    if (state is RemoteClothesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Display a pie chart and a text widget with the total number of male clothes
                    if (state is RemoteClothesDone) {
                      List<String> clothesTypes = state.clothes!
                          .where((element) =>
                              element
                                  .typeClothes!.categoryClothes!.nameCategory ==
                              'male')
                          .map((element) => element.typeClothes!.nameType!)
                          .toList();
                      Map<String, double> clothesCount = {};
                      for (var type in clothesTypes) {
                        clothesCount[type] = (clothesCount[type] ?? 0) + 1;
                      }
                      return Column(
                        children: [
                          BasicText(
                            title: 'total male clothes: ${clothesTypes.length}',
                          ),
                          BasicPieChart(inputData: clothesCount)
                        ],
                      );
                    }

                    // Display an error message if the state is RemoteClothesError
                    if (state is RemoteClothesError) {
                      return const Text("error");
                    }

                    // Return an empty widget if the state is not one of the previous cases
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
                                extra: {"male clothes"});
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
