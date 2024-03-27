import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:xc_web_admin/config/color.dart';
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
  final YandexGeocoder geo =
      YandexGeocoder(apiKey: dotenv.env['YANDEX_API_KEY']!);

  String shopLatitude = "";
  String shopLongitude = "";

  final ShopAddressDTO shopAddressDTO = ShopAddressDTO();
  @override

  /// Widget for the AddShopDialog.
  ///
  /// Displays a dialog with a map, text fields, and a button to add a new shop.
  Widget build(BuildContext context) {
    // Build the AddShopDialog widget.
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Display the title of the dialog.
            const BasicText(title: "add new shop"),

            // Build the main content of the dialog.
            Row(
              children: [
                // Build the map widget.
                _buildMapWidget(),

                // Build the text field widgets.
                _buildTextFieldWidgets(),
              ],
            ),

            // Build the button widget.
            _buildButtonWidget(),
          ],
        ),
      ),
    );
  }

  /// Builds the map widget.
  ///
  /// This function builds the widget for the map that is displayed in
  /// the AddShopDialog.
  Widget _buildMapWidget() {
    // Padding around the map widget.
    return Padding(
      padding: const EdgeInsets.all(8.0),

      // Sized box containing the map widget.
      child: SizedBox(
        width: 600, // Width of the map widget.
        height: 500, // Height of the map widget.
        child: FlutterMap(
          options: const MapOptions(
            initialZoom: 10, // Initial zoom level of the map.
            initialCenter:
                LatLng(55.753575, 37.62104), // Initial center of the map.
          ),
          children: [
            // Tile layer for the map.
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              tileDisplay: const TileDisplay.fadeIn(),
            ),

            // Marker layer for the map.
            MarkerLayer(markers: markers),
          ],
        ),
      ),
    );
  }

  /// Builds the text field widgets.
  ///
  /// This function builds the widgets for the text fields used to enter
  /// shop information such as shop address, shop metro, and contact number.
  Widget _buildTextFieldWidgets() {
    return Expanded(
      child: Column(
        children: [
          // Build the shop address text field.
          //
          // This widget allows the user to enter the address of the shop.
          // When the 'Find Address' button is pressed, it geocodes the
          // entered address and adds a marker to the map.
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

          // Build the shop metro text field.
          //
          // This widget allows the user to enter the metro station
          // where the shop is located.
          BasicTextField(
            title: "shop metro",
            controller: shopMetroController,
            isEnabled: true,
          ),

          // Build the contact number text field.
          //
          // This widget allows the user to enter the contact number
          // of the shop.
          BasicTextField(
            title: "contact number",
            controller: contactNumberController,
            isEnabled: true,
          ),
        ],
      ),
    );
  }

  /// Builds the button widget.
  ///
  /// This widget represents the button that is used to add a new shop.
  /// When pressed, the [addShop] function is called.
  Widget _buildButtonWidget() {
    // The button widget.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        // The function to be called when the button is pressed.
        onPressed: () async {
          addShop();
        },
        // The style of the button.
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBrown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        // The text to be displayed on the button.
        child: const BaseButtonText(title: "add new shop"),
      ),
    );
  }

  /// Adds a new shop to the shop addresses BLoC and navigates back to the admin
  /// shops screen.
  ///
  /// This function sets the values of [shopAddressDTO] based on the text
  /// entered into the text fields, and then adds the shop address to the
  /// [RemoteShopAddressesBloc] using the [AddShopAddress] event. After a
  /// delay of 3 seconds, the function navigates back to the admin shops screen
  /// using the [router].
  void addShop() async {
    // Set the values of [shopAddressDTO] based on the text entered into the
    // text fields
    shopAddressDTO.shopAddressDirection = shopAddressController.text;
    shopAddressDTO.latitude = shopLatitude;
    shopAddressDTO.longitude = shopLongitude;
    shopAddressDTO.shopMetro = shopMetroController.text;
    shopAddressDTO.contactNumber = contactNumberController.text;

    // Add the shop address to the [RemoteShopAddressesBloc] using the
    // [AddShopAddress] event
    service<RemoteShopAddressesBloc>().add(AddShopAddress(shopAddressDTO));

    // After a delay of 3 seconds, navigate back to the admin shops screen
    await Future.delayed(const Duration(seconds: 3));
    router.pop();
    router.push(Pages.adminShops.screenPath);
  }

  // Function to add a marker at the long-pressed location
  /// Adds a marker at the specified [latLng] location.
  ///
  /// This function clears any existing markers, adds a new marker at the
  /// specified [latLng] location, and updates the [shopLatitude] and
  /// [shopLongitude] values.
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
          width: 80.0,
          height: 80.0,
          point: latLng,
          // Icon representing the location on the map.
          child: const Icon(Icons.location_on, color: Colors.red),
        ),
      );

      // Update latitude and longitude values.
      shopLatitude = latLng.latitude.toString();
      shopLongitude = latLng.longitude.toString();
    });
  }
}
