import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_clothes_dto.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_state.dart';

class AddClothesDialog extends StatefulWidget {
  const AddClothesDialog({super.key});

  @override
  State<AddClothesDialog> createState() => _AddClothesDialogState();
}

class _AddClothesDialogState extends State<AddClothesDialog> {
  late final Map<String, TextEditingController> controllers;
  final TextEditingController photoURLController = TextEditingController();
  late final RemoteClothesBloc newBloc;
  List<int>? selectedSizes = [];
  List<int>? selectedColors = [];
  List<String>? uploadedPhotos = [];

  int? selectedGenderIndex = 0;
  int? selectedTypeClothesIndex = 0;

  final ClothesDTO newClothes = ClothesDTO();

  @override
  void initState() {
    super.initState();
    controllers = {
      'barcode': TextEditingController(text: ''),
      'nameClothesRu': TextEditingController(text: ''),
      'nameClothesEn': TextEditingController(text: ''),
      'priceClothes': TextEditingController(text: ''),
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
                                selectedTypeClothesIndex = value;
                              });
                            },
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

            // ! implement sizes and colors after adding corresponding blocs
            // const BasicText(title: "choose sizes"),
            // BlocProvider<RemoteSizesBloc>(
            //   create: (context) =>

            // )
            // const BasicText(title: "choose colors"),
            // BlocProvider<RemoteColorsBloc>(
            //   create: (context) =>

            // )
            // !

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
            )
          ],
        ),
      ),
    );
  }

  void addClothes() async {
    newClothes.barcode = controllers['barcode']!.text;
    newClothes.nameClothesRu = controllers['nameClothesRu']!.text;
    newClothes.nameClothesEn = controllers['nameClothesEn']!.text;
    newClothes.priceClothes = controllers['priceClothes']!.text;
    newClothes.uploadedPhotos = uploadedPhotos!;
    newClothes.selectedColors = selectedColors!;
    newClothes.selectedSizes = selectedSizes!;

    newBloc.add(AddClothes(clothesDTO: newClothes));

    newBloc.stream.listen((state) {
      if (state is RemoteClothesAddDone) {
        router.pop();
      } else if (state is RemoteClothesError) {
        showDialog(
          context: context,
          builder: (context) {
            //TODO: implement correct error handling
            return const AlertDialog(
              content: Text("smth went wrong"),
            );
          },
        );
      }
    });
  }
}
