import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/core/widget/widget/basic_color_container.dart';
import 'package:xc_web_admin/core/widget/widget/basic_sizes_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/model/clothes.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';

import '../../../../../core/constants/strings.dart';

class AdminClothesDetails extends StatefulWidget {
  final ClothesModel clothes;
  const AdminClothesDetails({super.key, required this.clothes});

  @override
  State<AdminClothesDetails> createState() => _AdminClothesDetailsState();
}

class _AdminClothesDetailsState extends State<AdminClothesDetails> {
  Map<String, TextEditingController> controllers = {
    "barcode": TextEditingController(),
    "name clothes ru": TextEditingController(),
    "name clothes en": TextEditingController(),
    "price clothes": TextEditingController(),
  };

  /// Initialize the state of the widget.
  ///
  /// This method is called immediately after the widget is created. It sets the
  /// initial values of the text fields based on the provided [ClothesModel].
  @override
  void initState() {
    // Call the superclass's initState method.
    super.initState();

    // Set the initial value of the 'barcode' text field.
    controllers["barcode"]!.text = widget.clothes.barcode!;

    // Set the initial value of the 'name clothes ru' text field.
    controllers["name clothes ru"]!.text = widget.clothes.nameClothesRu!;

    // Set the initial value of the 'name clothes en' text field.
    controllers["name clothes en"]!.text = widget.clothes.nameClothesEn!;

    // Set the initial value of the 'price clothes' text field.
    controllers["price clothes"]!.text = widget.clothes.priceClothes!;
  }

  @override

  /// Builds the UI for the clothes details screen.
  ///
  /// This function takes a [BuildContext] and returns a [Widget] that represents the UI for the clothes details screen.
  /// It uses a [Scaffold] widget to provide a material design layout structure.
  /// It uses a [SafeArea] widget to ensure that the screen's content is not obscured by the system UI.
  /// It uses a [SingleChildScrollView] widget to allow the user to scroll in case the content is too long to fit on the screen.
  /// It uses a [Column] widget to arrange its children vertically.
  /// It uses a [Row] widget to arrange its children horizontally.
  /// It uses an [IconButton] widget to display an arrow button that allows the user to navigate back.
  /// It uses a [HeaderText] widget to display the title of the screen.
  /// It uses a [Row] widget to display a carousel of photos for the clothes.
  /// It uses a [BasicTextField] widget to display text fields for user input.
  /// It uses a [Column] widget to arrange the [BasicTextField] widgets vertically.
  /// It uses a [_buildSizesRow] function to build a row of size buttons.
  /// It uses a [_buildColorsRow] function to build a row of color buttons.
  Widget build(BuildContext context) {
    // Check if the device is mobile
    final bool isMobile = Responsive.isMobile(context);

    // Build the UI for the clothes details screen
    return Scaffold(
      // Build the material design layout structure
      body: SafeArea(
        child: SingleChildScrollView(
          // Provide padding to ensure the content is not obscured by the system UI
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Build the row with the back button and the title
              Row(
                children: [
                  // Build the back button
                  IconButton(
                    // Adjust the padding to remove the button's default padding
                    padding: EdgeInsets.zero,
                    // Define the action to perform when the button is pressed
                    onPressed: () {
                      // Navigate back to the previous screen
                      router.pop(context);
                    },
                    // Define the icon to display on the button
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.darkBrown,
                      size: 30,
                    ),
                  ),
                  // Build the title
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: HeaderText(
                            textSize: isMobile ? 35 : 45,
                            title: 'clothes details',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Build the row with the carousel of photos and the text fields
              Row(
                children: [
                  // Build the carousel of photos
                  _buildPhotosCarousel(),
                  // Build the column of text fields and size and color buttons
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Build the text fields for user input
                        for (var field in controllers.keys)
                          BasicTextField(
                            title: field,
                            controller: Methods.getControllerForField(
                                controllers, field),
                            isEnabled: true,
                          ),

                        // Build the row of size buttons
                        _buildSizesRow(),
                        // Build the row of color buttons
                        _buildColorsRow(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a widget that displays a carousel of photos for the clothes.
  ///
  /// Uses the [RemoteClothesBloc] to fetch the photos.
  /// Uses the [BlocProvider] and [BlocBuilder] widgets to handle the state changes.
  /// Returns a [Widget] that displays a carousel of photos for the clothes.
  Widget _buildPhotosCarousel() {
    // Create a [BlocProvider] widget to provide the [RemoteClothesBloc] to its child.
    // Add a [GetClothesPhoto] event to the [RemoteClothesBloc].
    return BlocProvider(
      create: (context) => service<RemoteClothesBloc>()
        ..add(GetClothesPhoto(id: widget.clothes.idClothes!)),
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
              return const Text(errorLoadingImage);
          }
          // Return an empty [SizedBox] if the state is not handled.
          return const SizedBox();
        },
      ),
    );
  }

  /// Builds a row displaying the available sizes for the clothes.
  ///
  /// Uses the [RemoteClothesBloc] to fetch the sizes.
  /// Uses the [BlocProvider] and [BlocBuilder] widgets to handle the state changes.
  Widget _buildSizesRow() {
    // Create a [BlocProvider] widget to provide the [RemoteClothesBloc] to its child.
    return BlocProvider<RemoteClothesBloc>(
      // Create an instance of the [RemoteClothesBloc] and add a [GetClothesSizes] event to it.
      create: (context) => service<RemoteClothesBloc>()
        ..add(GetClothesSizes(id: widget.clothes.idClothes!)),
      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
        // Build the UI based on the state of the [RemoteClothesBloc].
        builder: (context, state) {
          // Handle the different states of the [RemoteClothesBloc].
          switch (state.runtimeType) {
            // When the state is [RemoteClothesLoading], show a circular progress indicator.
            case RemoteClothesLoading:
              return const CircularProgressIndicator();
            // When the state is [RemoteClothesSizeClothesDone], build the UI for the available sizes.
            case RemoteClothesSizeClothesDone:
              return Column(
                children: [
                  // Display a header text indicating the available sizes.
                  const HeaderText(
                    textSize: 20,
                    title: availableInSizes,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: List.generate(
                        state.clothesSizeClothes!.length,
                        // Generate a [SizesContainer] for each size.
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizesContainer(
                            // Display the name of the size.
                            title: state.clothesSizeClothes![index].sizeClothes!
                                .nameSize!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            // When the state is [RemoteClothesError], display an error message.
            case RemoteClothesError:
              return const Text(errorLoadingSizes);
          }
          // When none of the above states match, return an empty sized box.
          return const SizedBox();
        },
      ),
    );
  }

  /// Builds a row displaying the available colors for the clothes.
  ///
  /// Uses the [RemoteClothesBloc] to fetch the colors.
  /// Uses the [BlocProvider] and [BlocBuilder] widgets to handle the state changes.
  Widget _buildColorsRow() {
    // Create a [BlocProvider] widget to provide the [RemoteClothesBloc] to its child.
    return BlocProvider(
      // Create an instance of the [RemoteClothesBloc] and add a [GetClothesColors] event to it.
      create: (context) => service<RemoteClothesBloc>()
        ..add(GetClothesColors(id: widget.clothes.idClothes!)),
      // The child of the [BlocProvider] is a [BlocBuilder] widget.
      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
        // The builder function takes a [BuildContext] and a [RemoteClothesState] and returns a widget.
        builder: (context, state) {
          // Based on the type of the state, return a different widget.
          switch (state.runtimeType) {
            // If the state is [RemoteClothesLoading], return a [CircularProgressIndicator].
            case RemoteClothesLoading:
              return const CircularProgressIndicator();
            // If the state is [RemoteClothesColorsDone], return a [Column] widget with the available colors.
            case RemoteClothesColorsDone:
              return Column(
                children: [
                  // Add a [HeaderText] widget displaying "availableInColors".
                  const HeaderText(
                    textSize: 20,
                    title: availableInColors,
                  ),
                  // Add a [Padding] widget with a [Wrap] widget containing the available colors.
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: List.generate(
                        state.clothesColors!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ColorContainer(
                            // Get the color from the clothes colors at the current index and pass it to [ColorContainer].
                            color: Methods.getColorFromHex(
                                state.clothesColors![index].colors!.hex!),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            // If the state is [RemoteClothesError], return a [Text] widget displaying "errorLoadingColors".
            case RemoteClothesError:
              return const Text(errorLoadingColors);
          }
          // If none of the above cases match, return a [SizedBox].
          return const SizedBox();
        },
      ),
    );
  }
}
