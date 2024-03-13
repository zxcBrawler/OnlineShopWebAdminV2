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

  /// Builds the widget tree for the dialog.
  ///
  /// This method builds the widget tree for the dialog that is displayed
  /// when the user clicks on the "Add New Clothes" button. The widget tree
  /// consists of a [Dialog] widget that contains a [SingleChildScrollView]
  /// widget. The [SingleChildScrollView] widget contains a [Column] widget
  /// that contains several other widgets.
  ///
  /// The [Column] widget contains several other widgets. The first widget is
  /// a [BasicText] widget that displays the title "add new clothes".
  ///
  /// Next, the [Column] widget contains a widget returned by the
  /// `_buildGenderDropdown()` method. This widget displays a dropdown menu
  /// for selecting the gender of the clothes.
  ///
  /// After that, the [Column] widget contains a widget returned by the
  /// `_buildTypeClothesDropdown()` method. This widget displays a dropdown
  /// menu for selecting the type of clothes.
  ///
  /// Next, the [Column] widget contains a [BasicText] widget that displays
  /// the title "enter clothes details".
  ///
  /// After that, the [Column] widget contains several [BasicTextField] widgets.
  /// Each [BasicTextField] widget displays an input field for a specific
  /// field of the clothes details. The fields are obtained from the
  /// [controllers] map.
  ///
  /// Next, the [Column] widget contains a [BasicText] widget that displays
  /// the title "choose sizes".
  ///
  /// After that, the [Column] widget contains a widget returned by the
  /// `_buildSizesDropdown()` method. This widget displays a dropdown menu
  /// for selecting the size of the clothes.
  ///
  /// After that, the [Column] widget contains a widget returned by the
  /// `_buildSelectedSizes()` method. This widget displays the selected sizes
  /// of the clothes.
  ///
  /// Next, the [Column] widget contains a [BasicText] widget that displays
  /// the title "choose colors".
  ///
  /// After that, the [Column] widget contains a widget returned by the
  /// `_buildColorDropdown()` method. This widget displays a dropdown menu
  /// for selecting the color of the clothes.
  ///
  /// After that, the [Column] widget contains a widget returned by the
  /// `_buildSelectedColors()` method. This widget displays the selected colors
  /// of the clothes.
  ///
  /// Next, the [Column] widget contains a [BasicText] widget that displays
  /// the title "add photo URL".
  ///
  /// After that, the [Column] widget contains a widget returned by the
  /// `_buildPhotoURLTextField()` method. This widget displays an input field
  /// for entering the photo URL of the clothes.
  ///
  /// After that, the [Column] widget contains a widget returned by the
  /// `_buildAddedPhotos()` method. This widget displays the photos added
  /// for the clothes.
  ///
  /// Finally, the [Column] widget contains a widget returned by the
  /// `_buildAddClothesButton()` method. This widget displays a button for
  /// adding the clothes.
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(children: [
          // Display the title "add new clothes"
          const BasicText(
            title: "add new clothes",
          ),

          // Display the dropdown menu for selecting the gender of the clothes
          _buildGenderDropdown(),

          // Display the dropdown menu for selecting the type of clothes
          _buildTypeClothesDropdown(),

          // Display the title "enter clothes details"
          const BasicText(title: "enter clothes details"),

          // Display the input fields for the clothes details
          for (var field in controllers.keys)
            BasicTextField(
              title: field,
              controller: Methods.getControllerForField(
                controllers,
                field,
              ),
              isEnabled: true,
            ),

          // Display the title "choose sizes"
          const BasicText(title: "choose sizes"),

          // Display the dropdown menu for selecting the size of the clothes
          _buildSizesDropdown(),

          // Display the selected sizes of the clothes
          _buildSelectedSizes(),

          const BasicText(title: "choose colors"),

          // Display the dropdown menu for selecting the color of the clothes
          _buildColorDropdown(),

          // Display the selected colors of the clothes
          _buildSelectedColors(),

          // Display the title "add photo URL"
          const BasicText(title: "add photo URL"),

          // Display the input field for entering the photo URL of the clothes
          _buildPhotoURLTextField(),

          // Display the photos added for the clothes
          _buildAddedPhotos(),

          // Display the button for adding the clothes
          _buildAddClothesButton()
        ]),
      ),
    );
  }
  // Display the

  /// Adds clothes to the database.
  ///
  /// This function retrieves the text from the input fields and other
  /// selected values and creates a new [ClothesDTO] object. It then adds
  /// the clothes to the database using the [newBloc] and waits for the
  /// addition to complete. Afterwards, it pops the current route and
  /// navigates to the appropriate page based on the selected gender.
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

  /// Widget for building a dropdown list of genders.
  ///
  /// This widget uses BlocProvider and BlocBuilder to handle the state of the RemoteGendersBloc.
  /// It displays a dropdown list of genders and allows the user to select a gender.
  /// When a gender is selected, it updates the selectedGenderIndex and triggers a new event
  /// in the RemoteClothesBloc to get the type clothes for the selected gender.
  Widget _buildGenderDropdown() {
    // Use BlocProvider to provide the RemoteGendersBloc and its initial state
    return BlocProvider<RemoteGendersBloc>(
      create: (context) => service()..add(const GetGenders()),
      // Use BlocBuilder to listen to the state changes of the RemoteGendersBloc
      child: BlocBuilder<RemoteGendersBloc, RemoteGenderState>(
        builder: (_, state) {
          // Handle the different states of the RemoteGendersBloc
          switch (state) {
            // When the state is RemoteGenderLoading, return an empty SizedBox
            case RemoteGenderLoading():
              return const SizedBox();

            // When the state is RemoteGenderDone, return a Column with a BasicDropdown widget
            case RemoteGenderDone():
              return Column(
                children: [
                  BasicDropdown(
                    // Display a dropdown list of genders
                    listTitle: "choose gender",
                    dropdownData: state.genders!
                        .map((e) => e.nameCategory!)
                        .toList()
                        .reversed
                        .toList(),
                    // Set the selected index to the selectedGenderIndex
                    selectedIndex: selectedGenderIndex!,
                    // Call onIndexChanged when a gender is selected
                    onIndexChanged: (value) {
                      // Update the selectedGenderIndex and trigger a new event in the RemoteClothesBloc
                      setState(() {
                        selectedGenderIndex = value;

                        newBloc
                            .add(GetTypeClothes(id: selectedGenderIndex! + 1));
                      });
                    },
                    isColorDropdown: false,
                  ),
                ],
              );

            // When the state is RemoteGenderError, return a Text widget with the error message
            case RemoteGenderError():
              return const Text("error");
          }
          // When the state is not handled, return an empty SizedBox
          return const SizedBox();
        },
      ),
    );
  }

  /// Builds a dropdown widget for selecting type clothes.
  ///
  /// This function uses the `BlocProvider` widget to create a `RemoteClothesBloc` and adds a `GetTypeClothes` event to it.
  /// It then uses the `BlocBuilder` widget to listen to the state of the `RemoteClothesBloc`.
  /// Depending on the state, different UI elements are rendered.
  ///
  /// The UI elements rendered by the `BlocBuilder` widget include a `BasicDropdown` widget for the type clothes selection.
  Widget _buildTypeClothesDropdown() {
    return BlocProvider<RemoteClothesBloc>(
      // Create a new instance of RemoteClothesBloc
      create: (context) => newBloc,
      // Build the UI using the BlocBuilder widget
      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
        // Build the UI based on the state of the RemoteClothesBloc
        builder: (_, state) {
          // Check the runtime type of the state
          switch (state.runtimeType) {
            // If the state is RemoteClothesLoading, return an empty SizedBox
            case RemoteClothesLoading:
              return const SizedBox();
            // If the state is RemoteTypeClothesDone, return a Column containing a BasicDropdown widget
            case RemoteTypeClothesDone:
              return Column(
                children: [
                  BasicDropdown(
                    // Display a dropdown list of type clothes
                    listTitle: "choose type clothes",
                    dropdownData: state.typeClothes!
                        .map((e) => e.nameType ?? "")
                        .toList(),
                    // Set the selected index to the selectedTypeClothesIndex
                    selectedIndex: selectedTypeClothesIndex!,
                    // Call onIndexChanged when a type clothes is selected
                    onIndexChanged: (value) {
                      // Update the selectedTypeClothesIndex
                      setState(() {
                        selectedTypeClothesIndex =
                            state.typeClothes![value].idType;
                      });
                    },
                    isColorDropdown: false,
                  ),
                ],
              );
            // If the state is RemoteClothesError, return a Text widget with the error message
            case RemoteClothesError:
              return const Text("error");
            // If the state is not handled, return an empty SizedBox
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildSizesDropdown() {
    return BlocProvider<RemoteSizeBloc>(
        create: (context) => service()..add(const GetSizes()),
        child:
            BlocBuilder<RemoteSizeBloc, RemoteSizeState>(builder: (_, state) {
          switch (state) {
            case RemoteSizesLoading():
              return const SizedBox();
            case RemoteSizesDone():
              List<SizeClothesEntity> sizes = state.sizes!;
              return Column(
                children: [
                  BasicDropdown(
                    listTitle: "choose sizes",
                    dropdownData: sizes.map((e) => e.nameSize ?? "").toList(),
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
        }));
  }

  Widget _buildSelectedSizes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
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
    );
  }

  Widget _buildSelectedColors() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
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
                            selectedColorsForAdding?.remove(item.colorId!);
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
    );
  }

  Widget _buildColorDropdown() {
    return BlocProvider<RemoteColorBloc>(
        create: (context) => service()..add(const GetColors()),
        child:
            BlocBuilder<RemoteColorBloc, RemoteColorState>(builder: (_, state) {
          switch (state) {
            case RemoteColorsLoading():
              return const SizedBox();
            case RemoteColorsDone():
              List<ColorEntity> colors = state.colors!;
              return Column(
                children: [
                  BasicDropdown(
                    listTitle: "choose colors",
                    dropdownData: colors.map((e) => e.nameColor ?? "").toList(),
                    colorDropdownData: colors.map((e) => e.hex ?? "").toList(),
                    selectedIndex: 0,
                    onIndexChanged: (value) {
                      setState(() {
                        selectedColors.add(colors[value]);
                        selectedColorsForAdding?.add(colors[value].colorId!);
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
        }));
  }

  Widget _buildPhotoURLTextField() {
    return Row(
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
    );
  }

  Widget _buildAddedPhotos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
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
    );
  }

  Widget _buildAddClothesButton() {
    return Padding(
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
    );
  }
}
