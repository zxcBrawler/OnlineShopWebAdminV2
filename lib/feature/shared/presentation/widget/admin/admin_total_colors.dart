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

  /// Builds the UI for the [AdminColors] widget.
  ///
  /// This method uses the BlocProvider and BlocBuilder widgets to interact
  /// with the [RemoteColorBloc] bloc and build the UI based on the state of
  /// the bloc.
  ///
  /// The UI consists of a row containing a container with a text widget that
  /// displays the total number of colors and an icon button that navigates to
  /// the [adminAllColors] screen when pressed.
  Widget build(BuildContext context) {
    return BlocProvider<RemoteColorBloc>(
      /// Create an instance of [RemoteColorBloc] and add a [GetColors] event
      /// to it.
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
                        /// Build different widgets based on the state of
                        /// [RemoteColorBloc].
                        builder: (_, state) {
                          switch (state.runtimeType) {
                            case RemoteColorsLoading:

                              /// Display a circular progress indicator when the
                              /// state is [RemoteColorsLoading].
                              return const Center(
                                  child: CircularProgressIndicator());
                            case RemoteColorsDone:

                              /// Display the total number of colors when the
                              /// state is [RemoteColorsDone].
                              return BasicText(
                                title: 'total colors: ${state.colors!.length}',
                              );
                            case RemoteColorsError:

                              /// Display the text "error" when the state is
                              /// [RemoteColorsError].
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
                            /// Navigate to the [adminAllColors] screen when the
                            /// icon button is pressed.
                            router.go(Pages.adminAllColors.screenPath);
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
