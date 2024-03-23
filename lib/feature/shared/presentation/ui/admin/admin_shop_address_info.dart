import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_address_dto.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_event.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class AdminShopAddressInfo extends StatefulWidget {
  final ShopAddressModel shopAddressModel;
  const AdminShopAddressInfo({super.key, required this.shopAddressModel});

  @override
  State<AdminShopAddressInfo> createState() => _AdminShopAddressInfoState();
}

class _AdminShopAddressInfoState extends State<AdminShopAddressInfo> {
  final TextEditingController shopAddressController =
      TextEditingController(text: '');
  final TextEditingController shopMetroController =
      TextEditingController(text: '');
  final TextEditingController contactNumberController =
      TextEditingController(text: '');
  final TextEditingController latitudeController =
      TextEditingController(text: '');
  final TextEditingController longitudeController =
      TextEditingController(text: '');

  final ShopAddressDTO shopAddressDTO = ShopAddressDTO();
  List<Marker> markers = []; // List to hold markers
  final YandexGeocoder geo = YandexGeocoder(apiKey: yandexApiKey);

  String shopLatitude = "";
  String shopLongitude = "";

  /// Initialize the state of the widget.
  ///
  /// This method is called when the widget is inserted into the tree.
  @override
  void initState() {
    // Call the super class initState method.
    super.initState();

    // Set the text of the 'shopAddressDirection' controller to the
    // shopAddressDirection property of the shopAddressModel.
    shopAddressController.text = widget.shopAddressModel.shopAddressDirection!;

    // Set the text of the 'shopMetro' controller to the shopMetro property
    // of the shopAddressModel.
    shopMetroController.text = widget.shopAddressModel.shopMetro!;

    // Set the text of the 'contactNumber' controller to the contactNumber
    // property of the shopAddressModel.
    contactNumberController.text = widget.shopAddressModel.contactNumber!;

    // Set the text of the 'latitude' controller to the latitude property
    // of the shopAddressModel.
    latitudeController.text = widget.shopAddressModel.latitude!;

    // Set the text of the 'longitude' controller to the longitude property
    // of the shopAddressModel.
    longitudeController.text = widget.shopAddressModel.longitude!;

    // Add a marker to the list of markers
    markers.add(Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(double.parse(widget.shopAddressModel.latitude!),
          double.parse(widget.shopAddressModel.longitude!)),
      child: const Icon(Icons.location_on, color: Colors.red),
    ));
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
                          MarkerLayer(markers: markers)
                        ]),
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BasicTextField(
                          title: "shop address",
                          controller: shopAddressController,
                          isEnabled: true,
                          findAddress: () async {
                            final GeocodeResponse geocodeFromAddress =
                                await geo.getGeocode(DirectGeocodeRequest(
                              addressGeocode: shopAddressController.text,
                              lang: Lang.ru,
                            ));
                            _addMarker(LatLng(
                                geocodeFromAddress.firstPoint!.lon,
                                geocodeFromAddress.firstPoint!.lat));
                          },
                        ),
                        BasicTextField(
                            title: "shop metro",
                            controller: shopMetroController,
                            isEnabled: true),
                        BasicTextField(
                            title: "contact number",
                            controller: contactNumberController,
                            isEnabled: true),
                        BasicTextField(
                            title: "latitude",
                            controller: latitudeController,
                            isEnabled: false),
                        BasicTextField(
                            title: "longitude",
                            controller: longitudeController,
                            isEnabled: false),
                      ]),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  _updateShopAddress();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const BaseButtonText(title: "update shop"),
              ),
            )
          ]),
        ),
      )),
    );
  }

  void _updateShopAddress() async {
    shopAddressDTO.shopAddressesId = widget.shopAddressModel.shopAddressId!;
    shopAddressDTO.contactNumber = contactNumberController.text;
    shopAddressDTO.latitude = latitudeController.text;
    shopAddressDTO.longitude = longitudeController.text;
    shopAddressDTO.shopAddressDirection = shopAddressController.text;
    shopAddressDTO.shopMetro = shopMetroController.text;

    service<RemoteShopAddressesBloc>().add(UpdateShopAddress(shopAddressDTO));
    await Future.delayed(const Duration(seconds: 3));
    router.pop();
    router.push(Pages.adminShops.screenPath);
  }

  void _addMarker(LatLng latLng) {
    setState(() {
      // Clear existing markers
      markers.clear();

      // Add new marker
      markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: latLng,
        child: const Icon(Icons.location_on, color: Colors.red),
      ));
      latitudeController.text = latLng.latitude.toString();
      longitudeController.text = latLng.longitude.toString();
    });
  }
}
