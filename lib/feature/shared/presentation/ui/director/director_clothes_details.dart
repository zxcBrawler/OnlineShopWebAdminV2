import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/button/build_button.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/core/widget/widget/basic_color_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_garnish_dto.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_garnish.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_event.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class DirectorClothesDetails extends StatefulWidget {
  final ShopGarnishModel clothes;
  const DirectorClothesDetails({super.key, required this.clothes});

  @override
  State<DirectorClothesDetails> createState() => _DirectorClothesDetailsState();
}

class _DirectorClothesDetailsState extends State<DirectorClothesDetails> {
  Map<String, TextEditingController> controllers = {
    S.current.barcode: TextEditingController(),
    S.current.nameClothesRu: TextEditingController(),
    S.current.nameClothesEn: TextEditingController(),
    S.current.priceClothes: TextEditingController(),
    S.current.size: TextEditingController(),
    S.current.quantity: TextEditingController(),
  };

  final ShopGarnishDTO newQuantity = ShopGarnishDTO();

  @override
  @override
  void initState() {
    // Initialize the superclass
    super.initState();

    // Initialize the text editing controllers with the data from the widget

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

  /// Builds the widget tree for the DirectorClothesDetails screen.
  ///
  /// This function creates a [Scaffold] widget that contains a [SafeArea],
  /// which in turn contains a [SingleChildScrollView]. The [SingleChildScrollView]
  /// has a [Column] widget as its child. This [Column] widget contains several
  /// other widgets, including a [Row] for the header, a [Row] for the photos
  /// carousel and information column, and a [Row] for the edit and delete buttons.
  ///
  /// The [SingleChildScrollView] is used to handle vertical scrolling on smaller
  /// screens, and the [SafeArea] widget ensures that the screen's content is
  /// not covered by the system's UI (e.g. status bar).
  Widget build(BuildContext context) {
    // Check if the device is mobile
    final bool isMobile = Responsive.isMobile(context);

    return Scaffold(
      // Build the Scaffold widget
      body: SafeArea(
          // Build the SafeArea widget
          child: SingleChildScrollView(
              // Build the SingleChildScrollView widget
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Build the header row
                  Row(
                    children: [
                      // Build the back button
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          router.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.darkBrown,
                          size: 30,
                        ),
                      ),
                      // Build the title column
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Build the title widget
                            Expanded(
                              child: HeaderText(
                                textSize: isMobile ? 35 : 45,
                                title: S.current.clothesDetails,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Build the photos and information column row
                  Row(children: [
                    // Build the photos carousel widget
                    _buildPhotosCarousel(),
                    // Build the information column widget
                    _buildInfoColumn(),
                  ]),
                  // Build the edit and delete buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Build the edit button
                      buildButton(
                          S.current.edit, AppColors.darkBrown, _editQuantity),
                      // Build the delete button
                      buildButton(
                          S.current.delete, AppColors.red, _deleteFromShop),
                    ],
                  ),
                ],
              ))),
    );
  }

  /// Builds the information column widget.
  ///
  /// This function creates a [Column] widget that contains a series of
  /// [BasicTextField] and [BasicText] widgets. Each [BasicTextField] widget
  /// represents a field in the clothes details, and is populated with the
  /// corresponding controller and enabled state. The [ColorContainer] widget
  /// at the end of the column represents the color of the clothes.
  Widget _buildInfoColumn() {
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
              // Set the enabled state of the BasicTextField based on whether the
              // current field is "quantity".
              isEnabled: controllers[field]! == controllers[S.current.quantity]
                  ? true
                  : false,
            ),
          // Add a BasicText widget with the title "color".
          BasicText(title: S.current.color),
          // Add a ColorContainer widget with the color of the clothes.
          ColorContainer(
            color: Methods.getColorFromHex(
                widget.clothes.colorClothesGarnish!.colors!.hex!),
          ),
        ],
      ),
    );
  }

  /// Builds the photos carousel widget.
  ///
  /// This function creates a [BlocProvider] widget that provides a
  /// [RemoteClothesBloc] to its descendants. It adds a [GetClothesPhoto] event
  /// to the [RemoteClothesBloc] service with the id of the clothes. Inside the
  /// [BlocBuilder], it builds a [CarouselSlider] widget that displays the
  /// photos of the clothes. The photos are downloaded from the internet using
  /// the [CachedNetworkImage] widget.
  ///
  /// Returns the built [Widget].
  Widget _buildPhotosCarousel() {
    return BlocProvider(
      // Create a BlocProvider widget that provides a RemoteClothesBloc to its
      // descendants.
      create: (context) => service<RemoteClothesBloc>()
        // Add a GetClothesPhoto event to the RemoteClothesBloc service.
        ..add(GetClothesPhoto(
          // Get the id of the clothes.
          id: widget.clothes.sizeClothesGarnish!.clothes!.idClothes!,
        )),
      // Build a BlocBuilder widget.
      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
        // Build the widget based on the state of the RemoteClothesBloc.
        builder: (context, state) {
          // Switch on the runtime type of the state.
          switch (state.runtimeType) {
            // If the state is of type RemoteClothesLoading, display a
            // CircularProgressIndicator.
            case RemoteClothesLoading:
              return const CircularProgressIndicator();
            // If the state is of type RemotePhotosOfClothesDone, display a
            // CarouselSlider widget.
            case RemotePhotosOfClothesDone:
              return SizedBox(
                height: 500,
                width: 500,
                child: CarouselSlider(
                  // Map each photo of the clothes to a Center widget that
                  // displays the photo using the CachedNetworkImage widget.
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
            // If the state is of type RemoteClothesError, display a Text
            // widget with the error message.
            case RemoteClothesError:
              return Text(S.current.error);
          }
          // If none of the cases match, return an empty SizedBox.
          return const SizedBox();
        },
      ),
    );
  }

  /// Updates the quantity of clothes in the shop.
  ///
  /// This function prepares the [newQuantity] object with the updated quantity
  /// and the [shopGarnishId] from [widget.clothes]. Then, it adds an
  /// [UpdateQuantity] event to the [RemoteShopGarnishBloc] service. After
  /// waiting for 1 second, it pops the current route and navigates to the
  /// director clothes details page.
  void _editQuantity() async {
    // Prepare the new quantity DTO with the updated quantity and shopGarnishId
    newQuantity.shopGarnishId = widget.clothes.shopGarnishId!;
    newQuantity.quantity = int.parse(controllers[S.current.quantity]!.text);

    // Add an UpdateQuantity event to the RemoteShopGarnishBloc service
    service<RemoteShopGarnishBloc>()
        .add(UpdateQuantity(shopGarnishDTO: newQuantity));

    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Pop the current route and navigate to director clothes details page
    router.pop();

    // Navigate to the director clothes details page
    router.push(
      Pages.directorClothes.screenPath,
    );
  }

  /// Deletes clothes from the shop.
  ///
  /// This function deletes clothes from the shop by adding a
  /// [DeleteShopGarnish] event to the [RemoteShopGarnishBloc] service. After
  /// waiting for 1 second, it pops the current route and navigates to the
  /// director clothes list page.
  void _deleteFromShop() async {
    // Add a DeleteShopGarnish event to the RemoteShopGarnishBloc service
    service<RemoteShopGarnishBloc>()
        .add(DeleteShopGarnish(id: widget.clothes.shopGarnishId!));

    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Pop the current route and navigate to director clothes list page
    router.pop();

    // Navigate to the director clothes list page with the clothes parameter
    // so that the list page can refresh the list of clothes
    router.push(Pages.directorAllClothes.screenPath, extra: {"clothes"});
  }
}
