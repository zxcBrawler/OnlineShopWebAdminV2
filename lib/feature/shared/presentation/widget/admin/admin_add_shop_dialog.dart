import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/constants/constants.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_address_dto.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_event.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class AddShopDialog extends StatefulWidget {
  const AddShopDialog({super.key});

  @override
  State<AddShopDialog> createState() => _AddShopDialogState();
}

class _AddShopDialogState extends State<AddShopDialog> {
  final TextEditingController shopAddressController =
      TextEditingController(text: '');
  final TextEditingController shopMetroController =
      TextEditingController(text: '');
  final TextEditingController contactNumberController =
      TextEditingController(text: '');
  List<Marker> markers = []; // List to hold markers
  final YandexGeocoder geo = YandexGeocoder(apiKey: yandexApiKey);

  String shopLatitude = "";
  String shopLongitude = "";

  final ShopAddressDTO shopAddressDTO = ShopAddressDTO();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const BasicText(title: "add new shop"),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 600,
                    height: 500,
                    child: FlutterMap(
                        options: const MapOptions(
                            initialZoom: 10,
                            initialCenter: LatLng(55.753575, 37.62104)),
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
                          _addMarker(LatLng(geocodeFromAddress.firstPoint!.lon,
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
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  addShop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const BaseButtonText(title: "add new shop"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addShop() async {
    shopAddressDTO.shopAddressDirection = shopAddressController.text;
    shopAddressDTO.latitude = shopLatitude;
    shopAddressDTO.longitude = shopLongitude;
    shopAddressDTO.shopMetro = shopMetroController.text;
    shopAddressDTO.contactNumber = contactNumberController.text;

    service<RemoteShopAddressesBloc>().add(AddShopAddress(shopAddressDTO));
    await Future.delayed(const Duration(seconds: 3));
    router.pop();
    router.push(Pages.adminShops.screenPath);
  }

  // Function to add a marker at the long-pressed location
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
      shopLatitude = latLng.latitude.toString();
      shopLongitude = latLng.longitude.toString();
    });
  }
}
