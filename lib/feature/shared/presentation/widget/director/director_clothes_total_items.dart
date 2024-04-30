import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class DirectorTotalItems extends StatefulWidget {
  const DirectorTotalItems({super.key});

  @override
  State<DirectorTotalItems> createState() => _DirectorTotalItemsState();
}

class _DirectorTotalItemsState extends State<DirectorTotalItems> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteShopGarnishBloc>(
      // Create an instance of RemoteClothesBloc and add a GetClothes event to it
      create: (context) => service()
        ..add(GetShopGarnish(
            id: int.parse(SessionStorage.getValue("shopAddressId")))),
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
                      BlocBuilder<RemoteShopGarnishBloc,
                          RemoteShopGarnishState>(
                        // Build different widgets based on the state of RemoteClothesBloc
                        builder: (_, state) {
                          switch (state.runtimeType) {
                            case RemoteShopGarnishLoading:
                              // Display a circular progress indicator when the state is RemoteClothesLoading
                              return const Center(
                                  child: CircularProgressIndicator());
                            case RemoteShopGarnishDone:
                              int totalClothes = 0;
                              for (var item in state.shopGarnish!) {
                                totalClothes += item.quantity!;
                              }
                              // Display the total number of clothes when the state is RemoteClothesDone
                              return BasicText(
                                title:
                                    '${S.of(context).totalClothes}: $totalClothes',
                              );
                            case RemoteShopGarnishError:
                              // Display the text "error" when the state is RemoteClothesError
                              return Text(S.current.error);
                          }
                          return const SizedBox();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            router.go(Pages.directorAllClothes.screenPath,
                                extra: {S.of(context).allClothes});
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
