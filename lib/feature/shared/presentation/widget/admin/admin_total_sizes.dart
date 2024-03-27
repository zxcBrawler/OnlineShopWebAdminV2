import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_state.dart';

class AdminSizes extends StatefulWidget {
  const AdminSizes({super.key});

  @override
  State<AdminSizes> createState() => _AdminSizesState();
}

class _AdminSizesState extends State<AdminSizes> {
  @override

  /// Builds the widget tree for the [AdminSizes] widget.
  ///
  /// This method wraps the widget tree with a [BlocProvider] widget that provides
  /// an instance of [RemoteSizeBloc] to its descendants. It also creates an instance
  /// of [RemoteSizeBloc] and adds a [GetSizes] event to it. The widget tree consists of
  /// a [Row] widget with a single [Expanded] widget that wraps a [Padding] widget.
  /// The [Padding] widget wraps a [BasicContainer] widget. The [BasicContainer] widget
  /// wraps a [Padding] widget. The [Padding] widget wraps a [Row] widget. The [Row]
  /// widget contains two children. The first child is a [BlocBuilder] widget that
  /// builds a widget based on the current state of [RemoteSizeBloc]. The second
  /// child is a [Padding] widget that wraps an [IconButton] widget. The [IconButton]
  /// widget triggers a navigation to [Pages.adminAllSizes.screenPath] when pressed.
  Widget build(BuildContext context) {
    return BlocProvider<RemoteSizeBloc>(
      // Create an instance of RemoteSizeBloc and add a GetSizes event to it.
      create: (context) => service()..add(const GetSizes()),
      // The widget tree.
      child: Row(
        children: [
          Expanded(
            // Wrap the widget tree with Padding.
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                top: 20,
                left: 8,
                right: 8,
              ),
              child: BasicContainer(
                // Wrap the widget tree with Padding.
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // Align the children of the Row to the start.
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Build a widget based on the current state of RemoteSizeBloc.
                      BlocBuilder<RemoteSizeBloc, RemoteSizeState>(
                        builder: (_, state) {
                          // Determine which widget to build based on the type of the state.
                          switch (state.runtimeType) {
                            // Build a CircularProgressIndicator when the state is RemoteSizesLoading.
                            case RemoteSizesLoading:
                              return const Center(
                                  child: CircularProgressIndicator());
                            // Build a BasicText widget with the total number of sizes
                            // when the state is RemoteSizesDone.
                            case RemoteSizesDone:
                              return BasicText(
                                title: 'total sizes: ${state.sizes!.length}',
                              );
                            // Build a Text widget with the text "error" when the
                            // state is RemoteSizesError.
                            case RemoteSizesError:
                              return const Text("error");
                          }
                          return const SizedBox();
                        },
                      ),
                      // Wrap an IconButton widget with Padding.
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          // Trigger a navigation to Pages.adminAllSizes.screenPath when pressed.
                          onPressed: () {
                            router.go(Pages.adminAllSizes.screenPath);
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
