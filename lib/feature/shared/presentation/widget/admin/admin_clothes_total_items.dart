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
  Widget build(BuildContext context) {
    return BlocProvider<RemoteClothesBloc>(
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
                        builder: (_, state) {
                          switch (state.runtimeType) {
                            case RemoteClothesLoading:
                              return const Center(
                                  child: CircularProgressIndicator());
                            case RemoteClothesDone:
                              return BasicText(
                                title:
                                    'total clothes: ${state.clothes!.length}',
                              );
                            case RemoteClothesError:
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
