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
  Widget build(BuildContext context) {
    return BlocProvider<RemoteSizeBloc>(
      create: (context) => service()..add(const GetSizes()),
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
                      BlocBuilder<RemoteSizeBloc, RemoteSizeState>(
                        builder: (_, state) {
                          switch (state.runtimeType) {
                            case RemoteSizesLoading:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case RemoteSizesDone:
                              return BasicText(
                                title: 'total sizes: ${state.sizes!.length}',
                              );
                            case RemoteSizesError:
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
                              Pages.adminAllSizes.screenPath,
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
