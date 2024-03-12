import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_state.dart';

class AdminColors extends StatefulWidget {
  const AdminColors({super.key});

  @override
  State<AdminColors> createState() => _AdminColorsState();
}

class _AdminColorsState extends State<AdminColors> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteColorBloc>(
      create: (context) => service()..add(const GetColors()),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
              child: BasicContainer(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<RemoteColorBloc, RemoteColorState>(
                        builder: (_, state) {
                          switch (state.runtimeType) {
                            case RemoteColorsLoading:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case RemoteColorsDone:
                              return BasicText(
                                title: 'total colors: ${state.colors!.length}',
                              );
                            case RemoteColorsError:
                              // Display the text "error" when the state is RemoteClothesError
                              return const Text("error");
                          }
                          return const SizedBox();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            router.go(
                              Pages.adminAllColors.screenPath,
                            );
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
