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

  @override

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
                        ..add(GetClothesPhoto(id: widget.clothes.idClothes!)),
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
                        // Text fields for user input
                        // If controller value for the field is not null and is not empty, display the text field
                        for (var field in controllers.keys)
                          BasicTextField(
                            title: field,
                            controller: Methods.getControllerForField(
                                controllers, field),
                            isEnabled: true,
                          ),

                        BlocProvider<RemoteClothesBloc>(
                          create: (context) => service<RemoteClothesBloc>()
                            ..add(
                                GetClothesSizes(id: widget.clothes.idClothes!)),
                          child: BlocBuilder<RemoteClothesBloc,
                              RemoteClothesState>(
                            builder: (context, state) {
                              switch (state.runtimeType) {
                                case RemoteClothesLoading:
                                  return const CircularProgressIndicator();
                                case RemoteClothesSizeClothesDone:
                                  return Column(
                                    children: [
                                      const HeaderText(
                                        textSize: 20,
                                        title: availableInSizes,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          children: List.generate(
                                            state.clothesSizeClothes!.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizesContainer(
                                                title: state
                                                    .clothesSizeClothes![index]
                                                    .sizeClothes!
                                                    .nameSize!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                case RemoteClothesError:
                                  return const Text(errorLoadingSizes);
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        BlocProvider(
                            create: (context) => service<RemoteClothesBloc>()
                              ..add(GetClothesColors(
                                  id: widget.clothes.idClothes!)),
                            child: BlocBuilder<RemoteClothesBloc,
                                RemoteClothesState>(builder: (context, state) {
                              switch (state.runtimeType) {
                                case RemoteClothesLoading:
                                  return const CircularProgressIndicator();
                                case RemoteClothesColorsDone:
                                  return Column(
                                    children: [
                                      const HeaderText(
                                        textSize: 20,
                                        title: availableInColors,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          children: List.generate(
                                            state.clothesColors!.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ColorContainer(
                                                color: Methods.getColorFromHex(
                                                    state.clothesColors![index]
                                                        .colors!.hex!),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                case RemoteClothesError:
                                  return const Text(errorLoadingColors);
                              }
                              return const SizedBox();
                            }))
                      ],
                    )),
                  ])
                ],
              ))),
    );
  }
}
