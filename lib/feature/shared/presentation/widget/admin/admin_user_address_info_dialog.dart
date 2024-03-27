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

  /// Initializes the state of the [_UserAddressDialogState] object.
  ///
  /// This function is called when the widget is inserted into the tree. It
  /// updates the text fields with the values from the [widget.address]
  /// parameter and calls [_findAddress] to geocode the address.
  @override
  void initState() {
    // Call the parent class's initState function
    super.initState();

    // Set the text of the address name field
    addressNameController.text = widget.address.address!.nameAddress!;

    // Set the text of the direction address field
    addressDirectionController.text = widget.address.address!.directionAddress!;

    // Set the text of the city address field
    addressCityController.text = widget.address.address!.city!;

    // Call the _findAddress function to geocode the address
    _findAddress();
  }

  @override

  /// Builds the user address dialog widget.
  ///
  /// Returns a [Dialog] widget containing a [SingleChildScrollView] with a
  /// [Column] widget containing a [Row] widget with a [Padding] widget and an
  /// [Expanded] widget.
  ///
  /// The [Padding] widget contains a [SizedBox] widget with a [FlutterMap]
  /// widget. The [FlutterMap] widget displays a map with OpenStreetMap tiles,
  /// and a [MarkerLayer] widget containing markers.
  ///
  /// The [Expanded] widget contains a [Column] widget with [BasicTextField]
  /// widgets that display the address name, direction, and city of the user's
  /// address. These fields are disabled and contain the values of
  /// [addressNameController], [addressDirectionController], and
  /// [addressCityController] respectively.
  Widget build(BuildContext context) {
    return Dialog(
      // Build the dialog widget
      child: SingleChildScrollView(
        // Build the scrollable column of widgets
        child: Column(
          children: [
            Row(
              // Build the row containing the map and address info
              children: [
                Padding(
                  // Add padding around the map
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    // Set the size of the map container
                    width: 600,
                    height: 500,
                    child: FlutterMap(
                      // Build the map widget
                      options: const MapOptions(
                        initialZoom: 7,
                        initialCenter: LatLng(55.753575, 37.62104),
                      ),
                      children: [
                        TileLayer(
                          // Build the tile layer for the map
                          urlTemplate:
                              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName:
                              'dev.fleaflet.flutter_map.example',
                          tileDisplay: const TileDisplay.fadeIn(),
                        ),
                        MarkerLayer(markers: markers),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // Add the address info to the dialog
                  child: Column(
                    children: [
                      BasicTextField(
                        // Build the text field for the address name
                        title: "address name",
                        controller: addressNameController,
                        isEnabled: false,
                      ),
                      BasicTextField(
                        // Build the text field for the address direction
                        title: "address direction",
                        controller: addressDirectionController,
                        isEnabled: false,
                      ),
                      BasicTextField(
                        // Build the text field for the address city
                        title: "address city",
                        controller: addressCityController,
                        isEnabled: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Asynchronously finds the geographic coordinates of the address
  /// specified in [addressDirectionController].
  ///
  /// This function uses the [geo] object to perform a reverse geocode
  /// lookup and adds a marker to the map at the resulting coordinates.
  /// The marker is added by calling [_addMarker].
  void _findAddress() async {
    // Perform a reverse geocode lookup using the address entered by the user
    final GeocodeResponse geocodeFromAddress =
        await geo.getGeocode(DirectGeocodeRequest(
      addressGeocode: addressDirectionController.text,
      lang: Lang.ru,
    ));

    // Add a marker to the map at the resulting coordinates
    _addMarker(LatLng(geocodeFromAddress.firstPoint!.lon,
        geocodeFromAddress.firstPoint!.lat));
  }

  /// Adds a marker at the specified [latLng] location.
  ///
  /// This function clears any existing markers, adds a new marker at the
  /// specified [latLng] location, and updates the [latitude] and [longitude]
  /// values.
  ///
  /// The added marker is an [Icon] with a red color and location on icon.
  void _addMarker(LatLng latLng) {
    // Update state.
    setState(() {
      // Clear existing markers.
      markers.clear();

      // Add new marker.
      markers.add(
        Marker(
          // Width and height of the marker.
          width: 80.0,
          height: 80.0,
          // Point where the marker is placed.
          point: latLng,
          // Icon representing the location on the map.
          child: const Icon(Icons.location_on, color: Colors.red),
        ),
      );

      // Update latitude and longitude values.
      latitude = latLng.latitude;
      longitude = latLng.longitude;
    });
  }
}
