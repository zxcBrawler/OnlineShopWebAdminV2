import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget build(BuildContext context) {
    return BlocProvider<RemoteClothesBloc>(
      create: (context) => service()..add(const GetClothes()),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
          child: BasicContainer(
            child: Column(
              children: [
                BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
                  builder: (_, state) {
                    switch (state.runtimeType) {
                      case RemoteClothesLoading:
                        return const Center(child: CircularProgressIndicator());
                      case RemoteClothesDone:
                        List<String> clothesTypes = state.clothes!
                            .where((element) =>
                                element.typeClothes!.categoryClothes!
                                    .nameCategory ==
                                'female')
                            .map((clothes) => clothes.typeClothes!.nameType!)
                            .toList();
                        Map<String, double> clothesCount = {};
                        for (var type in clothesTypes) {
                          clothesCount[type] = (clothesCount[type] ?? 0) + 1;
                        }
                        return Column(
                          children: [
                            BasicText(
                              title:
                                  'total female clothes: ${clothesTypes.length}',
                            ),
                            BasicPieChart(inputData: clothesCount)
                          ],
                        );

                      case RemoteClothesError:
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
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            //router.go(Pages.adminAllUsers.screenPath);
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
