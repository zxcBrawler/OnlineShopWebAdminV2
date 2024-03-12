import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield_style.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_clothes_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_state.dart';

class AddClothesDialog extends StatefulWidget {
  const AddClothesDialog({super.key});

  @override
  State<AddClothesDialog> createState() => _AddClothesDialogState();
}

class _AddClothesDialogState extends State<AddClothesDialog> {
  late final Map<String, TextEditingController> controllers;
  final TextEditingController photoURLController = TextEditingController();
  late final RemoteClothesBloc newBloc;
  List<int>? selectedSizesForAdding = [];
  List<int>? selectedColorsForAdding = [];
  List<String>? uploadedPhotos = [];

  List<ColorEntity> selectedColors = [];
  List<SizeClothesEntity> selectedSizes = [];

  int? selectedGenderIndex = 0;
  int? selectedTypeClothesIndex = 0;

  final ClothesDTO newClothes = ClothesDTO();

  @override
  void initState() {
    super.initState();
    controllers = {
      'barcode': TextEditingController(
        text: '',
      ),
      'name clothes ru': TextEditingController(
        text: '',
      ),
      'name clothes en': TextEditingController(
        text: '',
      ),
      'price clothes': TextEditingController(text: ''),
    };

    newBloc = service<RemoteClothesBloc>()
      ..add(GetTypeClothes(id: selectedGenderIndex! + 1));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const BasicText(
              title: "add new clothes",
            ),
            BlocProvider<RemoteGendersBloc>(
              create: (context) => service()..add(const GetGenders()),
              child: BlocBuilder<RemoteGendersBloc, RemoteGenderState>(
                builder: (_, state) {
                  switch (state) {
                    case RemoteGenderLoading():
                      return const SizedBox();
                    case RemoteGenderDone():
                      return Column(
                        children: [
                          BasicDropdown(
                            listTitle: "choose gender",
                            dropdownData: state.genders!
                                .map((e) => e.nameCategory!)
                                .toList()
                                .reversed
                                .toList(),
                            selectedIndex: selectedGenderIndex!,
                            onIndexChanged: (value) {
                              setState(() {
                                selectedGenderIndex = value;
                                newBloc.add(GetTypeClothes(
                                    id: selectedGenderIndex! + 1));
                              });
                            },
                            isColorDropdown: false,
                          ),
                        ],
                      );

                    case RemoteGenderError():
                      return const Text("error");
                  }
                  return const SizedBox();
                },
              ),
            ),
            BlocProvider<RemoteClothesBloc>(
              create: (context) => newBloc,
              child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
                builder: (_, state) {
                  switch (state.runtimeType) {
                    case RemoteClothesLoading:
                      return const SizedBox();
                    case RemoteTypeClothesDone:
                      return Column(
                        children: [
                          BasicDropdown(
                            listTitle: "choose type clothes",
                            dropdownData: state.typeClothes!
                                .map((e) => e.nameType ?? "")
                                .toList(),
                            selectedIndex: selectedTypeClothesIndex!,
                            onIndexChanged: (value) {
                              setState(() {
                                selectedTypeClothesIndex =
                                    state.typeClothes![value].idType;
                              });
                            },
                            isColorDropdown: false,
                          ),
                        ],
                      );
                    case RemoteClothesError:
                      return const Text("error");
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
            const BasicText(title: "enter clothes details"),
            for (var field in controllers.keys)
              BasicTextField(
                title: field,
                controller: Methods.getControllerForField(
                  controllers,
                  field,
                ),
                isEnabled: true,
              ),
            const BasicText(title: "choose sizes"),
            BlocProvider<RemoteSizeBloc>(
                create: (context) => service()..add(const GetSizes()),
                child: BlocBuilder<RemoteSizeBloc, RemoteSizeState>(
                    builder: (_, state) {
                  switch (state) {
                    case RemoteSizesLoading():
                      return const SizedBox();
                    case RemoteSizesDone():
                      List<SizeClothesEntity> sizes = state.sizes!;
                      return Column(
                        children: [
                          BasicDropdown(
                            listTitle: "choose sizes",
                            dropdownData:
                                sizes.map((e) => e.nameSize ?? "").toList(),
                            selectedIndex: 0,
                            onIndexChanged: (value) {
                              setState(() {
                                selectedSizes.add(sizes[value]);
                                selectedSizesForAdding?.add(sizes[value].id!);
                              });
                            },
                            isColorDropdown: false,
                          ),
                        ],
                      );
                    case RemoteSizesError():
                      return const Text("error");
                  }
                  return const SizedBox();
                })),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 20),
                    child: Wrap(
                      children: [
                        if (selectedSizes.isNotEmpty)
                          for (var item in selectedSizes)
                            ListTile(
                              title: Text(
                                item.nameSize!,
                                style: basicTextFieldStyle(),
                              ),
                              trailing: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() {
                                    selectedSizes.remove(item);
                                    selectedSizesForAdding?.remove(item.id);
                                  });
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const BasicText(title: "choose colors"),
            BlocProvider<RemoteColorBloc>(
                create: (context) => service()..add(const GetColors()),
                child: BlocBuilder<RemoteColorBloc, RemoteColorState>(
                    builder: (_, state) {
                  switch (state) {
                    case RemoteColorsLoading():
                      return const SizedBox();
                    case RemoteColorsDone():
                      List<ColorEntity> colors = state.colors!;
                      return Column(
                        children: [
                          BasicDropdown(
                            listTitle: "choose colors",
                            dropdownData:
                                colors.map((e) => e.nameColor ?? "").toList(),
                            colorDropdownData:
                                colors.map((e) => e.hex ?? "").toList(),
                            selectedIndex: 0,
                            onIndexChanged: (value) {
                              setState(() {
                                selectedColors.add(colors[value]);
                                selectedColorsForAdding
                                    ?.add(colors[value].colorId!);
                              });
                            },
                            isColorDropdown: true,
                          ),
                        ],
                      );
                    case RemoteColorsError():
                      return const Text("error");
                  }
                  return const SizedBox();
                })),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 20),
                    child: Wrap(
                      children: [
                        if (selectedColors.isNotEmpty)
                          for (var item in selectedColors)
                            ListTile(
                              title: Text(
                                item.nameColor!,
                                style: basicTextFieldStyle(),
                              ),
                              leading: Icon(
                                Icons.circle,
                                color: Methods.getColorFromHex(item.hex!),
                              ),
                              trailing: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() {
                                    selectedColors.remove(item);
                                    selectedColorsForAdding
                                        ?.remove(item.colorId!);
                                  });
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const BasicText(title: "add photo URL"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BasicTextField(
                      title: "photo URL",
                      controller: photoURLController,
                      isEnabled: true),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 42),
                  child: SizedBox(
                    width: 150,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            uploadedPhotos!.add(photoURLController.text);
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 20),
                    child: Wrap(
                      children: [
                        for (var item in uploadedPhotos!)
                          Stack(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.fitHeight,
                                imageUrl: item,
                                height: 250,
                                width: 250,
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        uploadedPhotos!.remove(item);
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  addClothes();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const BaseButtonText(title: "add new clothes"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addClothes() async {
    newClothes.barcode = controllers['barcode']!.text;
    newClothes.nameClothesRu = controllers['name clothes ru']!.text;
    newClothes.nameClothesEn = controllers['name clothes en']!.text;
    newClothes.priceClothes = controllers['price clothes']!.text;
    newClothes.uploadedPhotos = uploadedPhotos!;
    newClothes.selectedColors = selectedColorsForAdding!;
    newClothes.selectedSizes = selectedSizesForAdding!;
    newClothes.selectedTypeClothes = selectedTypeClothesIndex!;

    newBloc.add(AddClothes(clothesDTO: newClothes));

    await Future.delayed(const Duration(seconds: 1));
    router.pop();
    if (selectedGenderIndex! + 1 == 1) {
      router.push(
        Pages.adminAllClothes.screenPath,
        extra: {"male clothes"},
      );
    } else {
      router.push(
        Pages.adminAllClothes.screenPath,
        extra: {"female clothes"},
      );
    }
  }
}
