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

  @override
  void initState() {
    super.initState();
    controllers["shopAddressDirection"]!.text =
        widget.shopAddressModel.shopAddressDirection!;
    controllers["shopMetro"]!.text = widget.shopAddressModel.shopMetro!;
    controllers["contactNumber"]!.text = widget.shopAddressModel.contactNumber!;
    controllers["latitude"]!.text = widget.shopAddressModel.latitude!;
    controllers["longitude"]!.text = widget.shopAddressModel.longitude!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
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
                )
              ],
            ),
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
