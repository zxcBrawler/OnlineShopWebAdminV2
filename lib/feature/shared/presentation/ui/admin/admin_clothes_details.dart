import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/model/clothes.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/photos_of_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AdminClothesDetails extends StatefulWidget {
  final ClothesModel clothes;
  const AdminClothesDetails({super.key, required this.clothes});

  @override
  State<AdminClothesDetails> createState() => _AdminClothesDetailsState();
}

class _AdminClothesDetailsState extends State<AdminClothesDetails> {
  late final TextEditingController barcodeController;
  late final TextEditingController nameRuController;
  late final TextEditingController nameEnController;
  late final TextEditingController priceController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    barcodeController = TextEditingController(text: widget.clothes.barcode);
    nameRuController =
        TextEditingController(text: widget.clothes.nameClothesRu);
    nameEnController =
        TextEditingController(text: widget.clothes.nameClothesEn);
    priceController = TextEditingController(text: widget.clothes.priceClothes);
    print(widget.clothes.idClothes);
  }

  @override
  Widget build(BuildContext context) {
    final fields = [
      "barcode",
      "name clothes ru",
      "name clothes en",
      "price clothes"
    ];

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
                              List<PhotosOfClothesEntity> images =
                                  state.photosOfClothes!;
                              return SizedBox(
                                height: 500,
                                width: 500,
                                child: CarouselSlider(
                                  items: images
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
                              return const Text("Error loading image");
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
                          for (var field in fields)
                            _getControllerForField(field).text.isNotEmpty
                                ? BasicTextField(
                                    title: field,
                                    controller: _getControllerForField(field),
                                    isEnabled: false,
                                  )
                                : const SizedBox(),
                        ]))
                  ])
                ],
              ))),
    );
  }

  // Function to get the controller for a specific input field
  TextEditingController _getControllerForField(String field) {
    switch (field) {
      case "barcode":
        return barcodeController;
      case "name clothes ru":
        return nameRuController;
      case "name clothes en":
        return nameEnController;
      case "price clothes":
        return priceController;

      default:
        throw Exception("Invalid field: $field");
    }
  }
}
