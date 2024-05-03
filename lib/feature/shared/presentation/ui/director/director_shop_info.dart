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
import 'package:xc_web_admin/generated/l10n.dart';

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

  /// Builds the user interface for the director shop info page.
  ///
  /// This function returns a [SafeArea] widget that wraps a
  /// [SingleChildScrollView]. The [SafeArea] is responsible for creating a
  /// safe area around the content to avoid any overlap with system UI. The
  /// [SingleChildScrollView] is responsible for allowing vertical scrolling.
  /// The [Column] widget contains a [Header] widget with the title 'my shop'
  /// and a [Row] widget that contains the result of the `_buildShopInfo()`
  /// function.
  @override
  Widget build(BuildContext context) {
    // Return the SafeArea widget that wraps the SingleChildScrollView
    return SafeArea(
      // Wrap the content with a SafeArea to avoid any overlap with system UI
      child: SingleChildScrollView(
        // Wrap the content with a SingleChildScrollView to allow vertical
        // scrolling
        padding: const EdgeInsets.all(16.0),
        // The column for the UI elements
        child: Column(
          // The children of the column
          children: [
            // Display the header
            Header(
              title: S.of(context).myShop,
            ),
            // Display the shop information
            Row(
              // The children of the row
              children: [
                // Build the shop information
                _buildShopInfo(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the widget for the shop information.
  ///
  /// This function returns a [BlocProvider] widget that wraps a
  /// [BlocBuilder]. The [BlocProvider] is responsible for creating a new
  /// instance of [RemoteEmployeeShopBloc] and adding the
  /// [GetShopAddressByEmployeeId] event to it. The [BlocBuilder] is responsible
  /// for building the UI based on the current state of [RemoteEmployeeShopBloc].
  Widget _buildShopInfo() {
    // Check if the device is mobile
    final isMobile = Responsive.isMobile(context);

    // Return a BlocProvider widget that wraps a BlocBuilder
    return BlocProvider<RemoteEmployeeShopBloc>(
      // Create a new instance of RemoteEmployeeShopBloc and add the event
      create: (context) => service()
        ..add(GetShopAddressByEmployeeId(
            employeeId: int.parse(SessionStorage.getValue("employeeId")))),
      child: BlocBuilder<RemoteEmployeeShopBloc, RemoteEmployeeShopState>(
        // Build the UI based on the current state of RemoteEmployeeShopBloc
        builder: (context, state) {
          // Handle the different states of the RemoteEmployeeShopBloc
          switch (state) {
            // If the state is loading, show a circular progress indicator
            case RemoteEmployeeShopLoading():
              return const CircularProgressIndicator();
            // If the state is RemoteShopAddressByEmployeeIdDone,
            // return either _buildMobileInfo or _buildDesktopInfo widget
            // based on the device type
            case RemoteShopAddressByEmployeeIdDone():
              return isMobile
                  ? _buildMobileInfo(state)
                  : _buildDesktopInfo(state);
            // If the state is RemoteEmployeeShopError, show an error text
            case RemoteEmployeeShopError():
              return Text(S.current.error);
          }
          // If none of the above states match, return an empty sized box
          return const SizedBox();
        },
      ),
    );
  }

  /// Builds the mobile information for the shop.
  ///
  /// This function returns a column widget that contains a map of the shop's
  /// location, contact number, address, and metro.
  Widget _buildMobileInfo(state) {
    // The column widget contains the shop information.
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The map widget displays the shop's location.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 300,
            height: 300,
            child: FlutterMap(
              options: MapOptions(
                initialZoom: 15,
                initialCenter: LatLng(
                  double.parse(state.shop!.shopAddresses!.latitude!),
                  double.parse(state.shop!.shopAddresses!.longitude!),
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  tileDisplay: const TileDisplay.fadeIn(),
                ),
                // The marker layer displays the shop's location.
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        double.parse(state.shop!.shopAddresses!.latitude!),
                        double.parse(state.shop!.shopAddresses!.longitude!),
                      ),
                      // The marker displays the shop's location.
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.location_on),
                        iconSize: 30,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // The basic text widget displays the shop's contact number.
        BasicText(title: "${S.of(context).contactNumber}: "),
        CardText(
          title: state.shop!.shopAddresses!.contactNumber!,
        ),
        // The basic text widget displays the shop's address.
        BasicText(title: "${S.of(context).shopAddress}: "),
        // The sized box widget displays the shop's address.
        SizedBox(
          width: 400,
          child: CardText(
            title: state.shop!.shopAddresses!.shopAddressDirection!,
          ),
        ),
        // The basic text widget displays the shop's metro.
        BasicText(title: "${S.of(context).shopMetro}: "),
        CardText(
          title: state.shop!.shopAddresses!.shopMetro!,
        ),
      ],
    );
  }

  /// Builds the desktop information for the shop.
  ///
  /// This function returns a Row widget that contains a map of the shop's
  /// location and information about the shop's contact number, address, and
  /// metro.
  Widget _buildDesktopInfo(state) {
    // The map widget displays the shop's location.
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // The map widget.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 500,
            height: 500,
            child: FlutterMap(
              options: MapOptions(
                initialZoom: 15,
                initialCenter: LatLng(
                  double.parse(state.shop!.shopAddresses!.latitude!),
                  double.parse(state.shop!.shopAddresses!.longitude!),
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  tileDisplay: const TileDisplay.fadeIn(),
                ),
                MarkerLayer(markers: [
                  Marker(
                    point: LatLng(
                      double.parse(state.shop!.shopAddresses!.latitude!),
                      double.parse(state.shop!.shopAddresses!.longitude!),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on),
                      iconSize: 30,
                      color: AppColors.red,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
        // The column widget that displays shop information.
        Column(
          children: [
            // The shop contact number.
            Row(
              children: [
                BasicText(title: "${S.of(context).contactNumber}: "),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: CardText(
                    title: state.shop!.shopAddresses!.contactNumber!,
                  ),
                ),
              ],
            ),
            // The shop address.
            Row(
              children: [
                BasicText(title: "${S.of(context).shopAddress}: "),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: CardText(
                    title: state.shop!.shopAddresses!.shopAddressDirection!,
                  ),
                ),
              ],
            ),
            // The shop metro.
            Row(
              children: [
                BasicText(title: "${S.of(context).shopMetro}: "),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: CardText(
                    title: state.shop!.shopAddresses!.shopMetro!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
