import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/strings.dart';
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

class DirectorClothesDetails extends StatefulWidget {
  final ShopGarnishModel clothes;
  const DirectorClothesDetails({super.key, required this.clothes});

  @override
  State<DirectorClothesDetails> createState() => _DirectorClothesDetailsState();
}

class _DirectorClothesDetailsState extends State<DirectorClothesDetails> {
  Map<String, TextEditingController> controllers = {
    "barcode": TextEditingController(),
    "name clothes ru": TextEditingController(),
    "name clothes en": TextEditingController(),
    "price clothes": TextEditingController(),
    "size clothes": TextEditingController(),
    "quantity": TextEditingController(),
  };

  final ShopGarnishDTO newQuantity = ShopGarnishDTO();

  @override
  void initState() {
    super.initState();

    controllers["barcode"]!.text =
        widget.clothes.sizeClothesGarnish!.clothes!.barcode!;
    controllers["name clothes ru"]!.text =
        widget.clothes.sizeClothesGarnish!.clothes!.nameClothesRu!;
    controllers["name clothes en"]!.text =
        widget.clothes.sizeClothesGarnish!.clothes!.nameClothesEn!;
    controllers["price clothes"]!.text =
        widget.clothes.sizeClothesGarnish!.clothes!.priceClothes!;
    controllers["size clothes"]!.text =
        widget.clothes.sizeClothesGarnish!.sizeClothes!.nameSize!;

    controllers["quantity"]!.text = widget.clothes.quantity!.toString();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
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
                  Row(children: [
                    BlocProvider(
                      create: (context) => service<RemoteClothesBloc>()
                        ..add(GetClothesPhoto(
                            id: widget.clothes.sizeClothesGarnish!.clothes!
                                .idClothes!)),
                      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case RemoteClothesLoading:
                              return const CircularProgressIndicator();
                            case RemotePhotosOfClothesDone:
                              return SizedBox(
                                height: 500,
                                width: 500,
                                child: CarouselSlider(
                                  items: state.photosOfClothes!
                                      .map((photo) => Center(
                                              child: CachedNetworkImage(
                                            imageUrl: photo
                                                .clothesPhoto!.photoAddress!,
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
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              );
                            case RemoteClothesError:
                              return const Text(errorLoadingImage);
                          }
                          return const SizedBox();
                        },
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
                            isEnabled:
                                controllers[field]! == controllers["quantity"]
                                    ? true
                                    : false,
                          ),
                        const BasicText(title: "color"),
                        ColorContainer(
                          color: Methods.getColorFromHex(
                              widget.clothes.colorClothesGarnish!.colors!.hex!),
                        )
                      ],
                    )),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Edit button
                      buildButton("Edit", AppColors.darkBrown, _editQuantity),
                      // Delete button
                      buildButton("Delete", AppColors.red, _deleteFromShop),
                    ],
                  ),
                ],
              ))),
    );
  }

  void _editQuantity() async {
    newQuantity.shopGarnishId = widget.clothes.shopGarnishId!;
    newQuantity.quantity = int.parse(controllers["quantity"]!.text);

    service<RemoteShopGarnishBloc>()
        .add(UpdateQuantity(shopGarnishDTO: newQuantity));

    await Future.delayed(const Duration(seconds: 1));
    router.pop();
    router.push(
      Pages.directorClothes.screenPath,
    );
  }

  void _deleteFromShop() async {
    service<RemoteShopGarnishBloc>()
        .add(DeleteShopGarnish(id: widget.clothes.shopGarnishId!));
    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));
    // Pop the current route and navigate to director clothes details page
    router.pop();
    router.push(Pages.directorAllClothes.screenPath, extra: {"clothes"});
  }
}
