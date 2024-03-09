import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';

class AdminTotalItems extends StatelessWidget {
  const AdminTotalItems({super.key});

  @override

  /// Builds the widget tree for the [AdminClothesTotalItems] widget.
  ///
  /// This widget uses a [BlocProvider] to create an instance of
  /// [RemoteClothesBloc] and adds a [GetClothes] event to it. The widget
  /// also uses a [BlocBuilder] to listen for changes in the state of
  /// [RemoteClothesBloc]. Depending on the runtime type of the state,
  /// different widgets are displayed.
  ///
  /// Parameters:
  ///   - [context]: The build context of this widget.
  ///
  /// Returns:
  ///   The widget tree for [AdminClothesTotalItems].
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteClothesBloc>(
      // Create an instance of RemoteClothesBloc and add a GetClothes event to it
      create: (context) => service()..add(const GetClothes()),
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
                      BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
                        // Build different widgets based on the state of RemoteClothesBloc
                        builder: (_, state) {
                          switch (state.runtimeType) {
                            case RemoteClothesLoading:
                              // Display a circular progress indicator when the state is RemoteClothesLoading
                              return const Center(
                                  child: CircularProgressIndicator());
                            case RemoteClothesDone:
                              // Display the total number of clothes when the state is RemoteClothesDone
                              return BasicText(
                                title:
                                    'total clothes: ${state.clothes!.length}',
                              );
                            case RemoteClothesError:
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
                          // Navigate to the adminAllClothes screen when the icon button is pressed
                          onPressed: () {
                            router.go(Pages.adminAllClothes.screenPath,
                                extra: {"clothes"});
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
