import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';

class AdminShopAddressInfo extends StatefulWidget {
  final ShopAddressModel shopAddressModel;
  const AdminShopAddressInfo({super.key, required this.shopAddressModel});

  @override
  State<AdminShopAddressInfo> createState() => _AdminShopAddressInfoState();
}

class _AdminShopAddressInfoState extends State<AdminShopAddressInfo> {
  Map<String, TextEditingController> controllers = {
    "shopAddressDirection": TextEditingController(),
    "shopMetro": TextEditingController(),
    "contactNumber": TextEditingController(),
    "latitude": TextEditingController(),
    "longitude": TextEditingController(),
  };

  /// Initialize the state of the widget.
  ///
  /// This method is called when the widget is inserted into the tree.
  @override
  void initState() {
    // Call the super class initState method.
    super.initState();

    // Set the text of the 'shopAddressDirection' controller to the
    // shopAddressDirection property of the shopAddressModel.
    controllers["shopAddressDirection"]!.text =
        widget.shopAddressModel.shopAddressDirection!;

    // Set the text of the 'shopMetro' controller to the shopMetro property
    // of the shopAddressModel.
    controllers["shopMetro"]!.text = widget.shopAddressModel.shopMetro!;

    // Set the text of the 'contactNumber' controller to the contactNumber
    // property of the shopAddressModel.
    controllers["contactNumber"]!.text = widget.shopAddressModel.contactNumber!;

    // Set the text of the 'latitude' controller to the latitude property
    // of the shopAddressModel.
    controllers["latitude"]!.text = widget.shopAddressModel.latitude!;

    // Set the text of the 'longitude' controller to the longitude property
    // of the shopAddressModel.
    controllers["longitude"]!.text = widget.shopAddressModel.longitude!;
  }

  @override

  /// Builds the widget tree for the [AdminShopAddressInfo] screen.
  ///
  /// This method returns a [Scaffold] widget with a [SafeArea] and a
  /// [SingleChildScrollView]. Inside the [SingleChildScrollView], there is a
  /// [Padding] widget with a [Column] containing a [Row] for the header and a
  /// [Row] for the map and form. The header [Row] contains an [IconButton] for
  /// navigating back and a [HeaderText] widget for the title. The map [Row]
  /// contains a [FlutterMap] widget with a [TileLayer] and a [MarkerLayer].
  /// The form [Row] contains a list of [BasicTextField] widgets generated using
  /// the [controllers] map.
  ///
  /// The [context] parameter is the build context for this widget.
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            // Header Row
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.darkBrown,
                        size: 30,
                      )),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: (Responsive.isMobile(context))
                              ? const HeaderText(
                                  textSize: 35, title: 'shop address details')
                              : const HeaderText(
                                  textSize: 45, title: 'shop address details')),
                    ],
                  ),
                ),
              ],
            ),
            // Map and Form Row
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 600,
                    height: 500,
                    child: FlutterMap(
                        options: MapOptions(
                            initialZoom: 15,
                            initialCenter: LatLng(
                                double.parse(widget.shopAddressModel.latitude!),
                                double.parse(
                                    widget.shopAddressModel.longitude!))),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                            tileDisplay: const TileDisplay.fadeIn(),
                          ),
                          MarkerLayer(markers: [
                            Marker(
                                point: LatLng(
                                    double.parse(
                                        widget.shopAddressModel.latitude!),
                                    double.parse(
                                        widget.shopAddressModel.longitude!)),
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
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var field in controllers.keys)
                          BasicTextField(
                            title: field,
                            controller: Methods.getControllerForField(
                                controllers, field),
                            isEnabled: true,
                          ),
                      ]),
                )
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
