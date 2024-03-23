import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/widget/header/basic_pages_header.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/text/card_text.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/employee_shop/employee_shop_state.dart';

class DirectorShopInfo extends StatefulWidget {
  const DirectorShopInfo({super.key});

  @override
  State<DirectorShopInfo> createState() => _DirectorShopInfoState();
}

class _DirectorShopInfoState extends State<DirectorShopInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Header(
              title: 'my shop',
            ),
            Row(
              // Display the UI for the AdminShopsTable widget in a row
              children: [
                BlocProvider<RemoteEmployeeShopBloc>(
                    create: (context) => service()
                      ..add(GetShopAddressByEmployeeId(
                          employeeId: int.parse(
                              SessionStorage.getValue("employeeId")))),
                    child: BlocBuilder<RemoteEmployeeShopBloc,
                        RemoteEmployeeShopState>(
                      builder: (context, state) {
                        switch (state) {
                          case RemoteEmployeeShopLoading():
                            return const CircularProgressIndicator();
                          case RemoteShopAddressByEmployeeIdDone():
                            return isMobile
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: FlutterMap(
                                              options: MapOptions(
                                                  initialZoom: 15,
                                                  initialCenter: LatLng(
                                                      double.parse(state
                                                          .shop!
                                                          .shopAddresses!
                                                          .latitude!),
                                                      double.parse(state
                                                          .shop!
                                                          .shopAddresses!
                                                          .longitude!))),
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                      "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                  userAgentPackageName:
                                                      'dev.fleaflet.flutter_map.example',
                                                  tileDisplay: const TileDisplay
                                                      .fadeIn(),
                                                ),
                                                MarkerLayer(markers: [
                                                  Marker(
                                                      point: LatLng(
                                                          double.parse(state
                                                              .shop!
                                                              .shopAddresses!
                                                              .latitude!),
                                                          double.parse(state
                                                              .shop!
                                                              .shopAddresses!
                                                              .longitude!)),
                                                      child: IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          Icons.location_on,
                                                        ),
                                                        iconSize: 30,
                                                        color: AppColors.red,
                                                      ))
                                                ])
                                              ]),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const BasicText(
                                                      title:
                                                          "shop contact number: "),
                                                  CardText(
                                                      title: state
                                                          .shop!
                                                          .shopAddresses!
                                                          .contactNumber!),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const BasicText(
                                                      title: "shop address: "),
                                                  CardText(
                                                      title: state
                                                          .shop!
                                                          .shopAddresses!
                                                          .shopAddressDirection!),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const BasicText(
                                                      title: "shop metro: "),
                                                  CardText(
                                                      title: state
                                                          .shop!
                                                          .shopAddresses!
                                                          .shopMetro!),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 600,
                                          height: 600,
                                          child: FlutterMap(
                                              options: MapOptions(
                                                  initialZoom: 15,
                                                  initialCenter: LatLng(
                                                      double.parse(state
                                                          .shop!
                                                          .shopAddresses!
                                                          .latitude!),
                                                      double.parse(state
                                                          .shop!
                                                          .shopAddresses!
                                                          .longitude!))),
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                      "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                  userAgentPackageName:
                                                      'dev.fleaflet.flutter_map.example',
                                                  tileDisplay: const TileDisplay
                                                      .fadeIn(),
                                                ),
                                                MarkerLayer(markers: [
                                                  Marker(
                                                      point: LatLng(
                                                          double.parse(state
                                                              .shop!
                                                              .shopAddresses!
                                                              .latitude!),
                                                          double.parse(state
                                                              .shop!
                                                              .shopAddresses!
                                                              .longitude!)),
                                                      child: IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          Icons.location_on,
                                                        ),
                                                        iconSize: 30,
                                                        color: AppColors.red,
                                                      ))
                                                ])
                                              ]),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              const BasicText(
                                                  title:
                                                      "shop contact number: "),
                                              CardText(
                                                  title: state
                                                      .shop!
                                                      .shopAddresses!
                                                      .contactNumber!),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const BasicText(
                                                  title: "shop address: "),
                                              CardText(
                                                  title: state
                                                      .shop!
                                                      .shopAddresses!
                                                      .shopAddressDirection!),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const BasicText(
                                                  title: "shop metro: "),
                                              CardText(
                                                  title: state
                                                      .shop!
                                                      .shopAddresses!
                                                      .shopMetro!),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                          case RemoteEmployeeShopError():
                            return const Text("error");
                        }
                        return const SizedBox();
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
