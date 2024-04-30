import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';

import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/core/widget/widget/basic_color_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_garnish.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class EmployeeClothesDetails extends StatefulWidget {
  final ShopGarnishModel clothes;
  const EmployeeClothesDetails({super.key, required this.clothes});

  @override
  State<EmployeeClothesDetails> createState() => _EmployeeClothesDetailsState();
}

class _EmployeeClothesDetailsState extends State<EmployeeClothesDetails> {
  Map<String, TextEditingController> controllers = {
    S.current.barcode: TextEditingController(),
    S.current.nameClothesRu: TextEditingController(),
    S.current.nameClothesEn: TextEditingController(),
    S.current.priceClothes: TextEditingController(),
    S.current.size: TextEditingController(),
    S.current.quantity: TextEditingController(),
  };

  @override
  void initState() {
    super.initState();

    /// Initialize the barcode controller
    controllers[S.current.barcode]!.text =
        widget.clothes.sizeClothesGarnish!.clothes!.barcode!;

    /// Initialize the name clothes ru controller
    controllers[S.current.nameClothesRu]!.text =
        widget.clothes.sizeClothesGarnish!.clothes!.nameClothesRu!;

    /// Initialize the name clothes en controller
    controllers[S.current.nameClothesEn]!.text =
        widget.clothes.sizeClothesGarnish!.clothes!.nameClothesEn!;

    /// Initialize the price clothes controller
    controllers[S.current.priceClothes]!.text =
        widget.clothes.sizeClothesGarnish!.clothes!.priceClothes!;

    /// Initialize the size clothes controller
    controllers[S.current.size]!.text =
        widget.clothes.sizeClothesGarnish!.sizeClothes!.nameSize!;

    /// Initialize the quantity controller
    controllers[S.current.quantity]!.text = widget.clothes.quantity!.toString();
  }

  @override

  /// Builds the main widget for the clothes details page.
  ///
  /// This function returns a [Scaffold] widget that contains a [SafeArea] widget.
  /// The [SafeArea] widget contains a [SingleChildScrollView] widget. The
  /// [SingleChildScrollView] widget contains a [Column] widget. The [Column]
  /// widget contains two [Row] widgets. The first [Row] widget contains an
  /// [IconButton] and an [Expanded] widget. The second [Row] widget contains two
  /// widgets returned by [_buildPhotosCarousel] and [_buildInfo] functions.
  ///
  /// Parameters:
  ///   - context: The [BuildContext] of the widget.
  ///
  /// Returns:
  ///   A [Scaffold] widget that contains a [SafeArea] widget.
  Widget build(BuildContext context) {
    // Check if the device is a mobile device
    final bool isMobile = Responsive.isMobile(context);

    // Build the main Scaffold widget
    return Scaffold(
      body: SafeArea(
        // Wrap the content in a SingleChildScrollView
        child: SingleChildScrollView(
          // Set padding for the content
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Build the main content
            children: [
              // Build the first Row widget
              Row(
                children: [
                  // Build the back button
                  IconButton(
                    // Set padding for the back button
                    padding: EdgeInsets.zero,
                    // Set the function to call when the back button is pressed
                    onPressed: () {
                      router.pop(context);
                    },
                    // Set the icon for the back button
                    icon: Icon(
                      Icons.arrow_back,
                      // Set the color of the back button icon
                      color: AppColors.darkBrown,
                      // Set the size of the back button icon
                      size: 30,
                    ),
                  ),
                  // Build the second Row widget
                  Expanded(
                    // Build the header text widget
                    child: Row(
                      // Set the main axis alignment to start
                      mainAxisAlignment: MainAxisAlignment.start,
                      // Build the header text widget
                      children: [
                        // Build the header text widget
                        Expanded(
                          child: HeaderText(
                            // Set the text size based on the device type
                            textSize: isMobile ? 35 : 45,
                            // Set the title of the header text
                            title: S.current.clothesDetails,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Build the second Row widget
              Row(
                // Build the photos carousel widget and the info widget
                children: [_buildPhotosCarousel(), _buildInfo()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the photos carousel widget for the clothes details page.
  ///
  /// This function returns a [BlocProvider] widget that wraps a [BlocBuilder].
  /// The [BlocProvider] is used to provide the [RemoteClothesBloc] to its child.
  /// The [BlocBuilder] is used to build the widget based on the state of the
  /// [RemoteClothesBloc]. The [GetClothesPhoto] event is added to the [RemoteClothesBloc].
  /// The different states of the [RemoteClothesBloc] are handled in the switch
  /// statement and the corresponding widget is returned.
  Widget _buildPhotosCarousel() {
    // Create a [BlocProvider] widget to provide the [RemoteClothesBloc] to its child.
    return BlocProvider(
      // Create the [RemoteClothesBloc] and add a [GetClothesPhoto] event to it.
      create: (context) => service<RemoteClothesBloc>()
        ..add(GetClothesPhoto(
            id: widget.clothes.sizeClothesGarnish!.clothes!.idClothes!)),
      // Build the widget based on the state of the [RemoteClothesBloc].
      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
        builder: (context, state) {
          // Handle the different states of the [RemoteClothesBloc].
          switch (state.runtimeType) {
            // Display a loading indicator if the state is [RemoteClothesLoading].
            case RemoteClothesLoading:
              return const CircularProgressIndicator();
            // Display a carousel of photos if the state is [RemotePhotosOfClothesDone].
            case RemotePhotosOfClothesDone:
              // Map each photo to a [CachedNetworkImage] widget and wrap it in a [Center] widget.
              // Create a [CarouselSlider] widget with the photos.
              return SizedBox(
                height: 500,
                width: 500,
                child: CarouselSlider(
                  items: state.photosOfClothes!
                      .map((photo) => Center(
                              child: CachedNetworkImage(
                            imageUrl: photo.clothesPhoto!.photoAddress!,
                            fit: BoxFit.fill,
                            height: 500,
                            width: 500,
                          )))
                      .toList(),
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              );
            // Display an error message if the state is [RemoteClothesError].
            case RemoteClothesError:
              return Text(S.current.error);
          }
          // Return an empty sized box if none of the states match.
          return const SizedBox();
        },
      ),
    );
  }

  /// Builds the info widget for the clothes details page.
  ///
  /// This function returns an [Expanded] widget containing a [Column]
  /// with multiple [BasicTextField] widgets and a [ColorContainer] widget.
  /// The [BasicTextField] widgets are generated using a loop that iterates
  /// over the keys of the [controllers] map. Each [BasicTextField] is
  /// initialized with the corresponding field name, controller, and disabled
  /// state. The last item in the column is a [BasicText] widget with the
  /// title "color", and a [ColorContainer] widget with the clothes' color.
  Widget _buildInfo() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Loop over each field in the controllers map and create a BasicTextField
          // widget for it.
          for (var field in controllers.keys)
            BasicTextField(
              // Set the title of the BasicTextField to the current field.
              title: field,
              // Get the controller for the current field from the controllers map.
              controller: Methods.getControllerForField(controllers, field),
              // Set the enabled state of the BasicTextField to false.
              isEnabled: false,
            ),
          // Add a BasicText widget with the title "color".
          BasicText(title: S.current.color),
          // Add a ColorContainer widget with the clothes' color.
          ColorContainer(
            color: Methods.getColorFromHex(
                widget.clothes.colorClothesGarnish!.colors!.hex!),
          ),
        ],
      ),
    );
  }
}
