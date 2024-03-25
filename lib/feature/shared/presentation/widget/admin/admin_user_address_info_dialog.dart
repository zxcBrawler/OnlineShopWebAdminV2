import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/feature/shared/data/model/user_address.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class UserAddressDialog extends StatefulWidget {
  final UserAddressModel address;
  const UserAddressDialog({super.key, required this.address});

  @override
  State<UserAddressDialog> createState() => _UserAddressDialogState();
}

class _UserAddressDialogState extends State<UserAddressDialog> {
  final TextEditingController addressNameController =
      TextEditingController(text: '');
  final TextEditingController addressDirectionController =
      TextEditingController(text: '');
  final TextEditingController addressCityController =
      TextEditingController(text: '');
  List<Marker> markers = []; // List to hold markers
  final YandexGeocoder geo =
      YandexGeocoder(apiKey: dotenv.env['YANDEX_API_KEY']!);
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressNameController.text = widget.address.address!.nameAddress!;
    addressDirectionController.text = widget.address.address!.directionAddress!;
    addressCityController.text = widget.address.address!.city!;
    _findAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 600,
                    height: 500,
                    child: FlutterMap(
                        options: const MapOptions(
                            initialZoom: 7,
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
                        title: "address name",
                        controller: addressNameController,
                        isEnabled: false,
                      ),
                      BasicTextField(
                          title: "address direction",
                          controller: addressDirectionController,
                          isEnabled: false),
                      BasicTextField(
                          title: "address city",
                          controller: addressCityController,
                          isEnabled: false),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _findAddress() async {
    final GeocodeResponse geocodeFromAddress =
        await geo.getGeocode(DirectGeocodeRequest(
      addressGeocode: addressDirectionController.text,
      lang: Lang.ru,
    ));

    _addMarker(LatLng(geocodeFromAddress.firstPoint!.lon,
        geocodeFromAddress.firstPoint!.lat));
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
      latitude = latLng.latitude;
      longitude = latLng.longitude;
    });
  }
}
