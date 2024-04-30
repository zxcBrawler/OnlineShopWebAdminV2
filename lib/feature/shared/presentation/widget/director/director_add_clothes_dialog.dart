import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_garnish_dto.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class DirectorAddClothesDialog extends StatefulWidget {
  const DirectorAddClothesDialog({super.key});

  @override
  State<DirectorAddClothesDialog> createState() =>
      _DirectorAddClothesDialogState();
}

class _DirectorAddClothesDialogState extends State<DirectorAddClothesDialog> {
  late final RemoteClothesBloc colorBloc;
  late final RemoteClothesBloc sizeBloc;
  bool ifExists = false;
  int? selectedClothesIndex;
  int? selectedColorIndex = 0;
  int? selectedSizeIndex = 0;
  int? colorForAdding = 0;
  int? sizeForAdding = 0;
  int? selectedClothesForAdding = 0;
  MaskedTextController quantity = MaskedTextController(mask: '0000');
  final ShopGarnishDTO newShopGarnish = ShopGarnishDTO();

  @override
  void initState() {
    super.initState();
    colorBloc = service<RemoteClothesBloc>()
      ..add(const GetClothesColors(id: 1));
    sizeBloc = service<RemoteClothesBloc>()..add(const GetClothesSizes(id: 1));
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
  /// a [BasicText] widget that displays the title "add clothes".
  ///
  /// Next, the [Column] widget contains a widget returned by the
  /// `_buildClothesDropdown()` method. This widget displays a dropdown menu
  /// for selecting the clothes.
  ///
  /// After that, the [Column] widget contains a [BasicTextField] widget that
  /// displays an input field for entering the quantity of clothes.
  ///
  /// Lastly, the [Column] widget contains a widget returned by the
  /// `_buildAddClothesButton()` method. This widget displays a button that
  /// triggers the addition of new clothes.
  Widget build(BuildContext context) {
    return Dialog(
      // The dialog widget
      child: SingleChildScrollView(
        // The dialog content is a SingleChildScrollView widget
        child: Column(
          // The dialog content is a Column widget
          children: [
            // A BasicText widget displaying the title "add clothes"
            BasicText(title: S.current.addNewClothes),

            // A widget returned by the _buildClothesDropdown() method
            _buildClothesDropdown(),

            // A BasicTextField widget displaying an input field for entering
            // the quantity of clothes
            BasicTextField(
              title: S.current.enterQuantity,
              controller: quantity,
              isEnabled: true,
            ),

            // A widget returned by the _buildAddClothesButton() method
            _buildAddClothesButton()
          ],
        ),
      ),
    );
  }

  /// Builds a widget that displays a dropdown menu for selecting clothes.
  ///
  /// This function uses the BlocProvider and BlocBuilder widgets to fetch
  /// the remote clothes data and update the dropdown menu accordingly.
  /// It returns a Column widget containing a BasicDropdown widget for
  /// selecting clothes, and two other widgets that display sizes and colors
  /// dropdown menus based on the selected clothes.
  Widget _buildClothesDropdown() {
    // Use BlocProvider to create a RemoteClothesBloc instance and add a
    // GetClothes event to fetch the remote clothes data
    return BlocProvider<RemoteClothesBloc>(
      create: (context) => service()..add(const GetClothes()),
      // Use BlocBuilder to listen to changes in the RemoteClothesBloc state
      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
        builder: (context, state) {
          // Handle the different states of the RemoteClothesBloc
          switch (state.runtimeType) {
            // Show a loading indicator if the state is RemoteClothesLoading
            case RemoteClothesLoading:
              return const CircularProgressIndicator();

            // Build the dropdown menu if the state is RemoteClothesDone
            case RemoteClothesDone:
              return Column(
                children: [
                  // Build a BasicDropdown widget for selecting clothes
                  BasicDropdown(
                    listTitle: S.current.chooseClothes,
                    // Map each RemoteClothes object to a String and build a list of options
                    dropdownData: state.clothes!
                        .map((e) => "${e.barcode} - ${e.nameClothesEn}")
                        .toList(),
                    selectedIndex: selectedClothesIndex ?? 0,
                    // Update the selected index and selected clothes when the index changes
                    onIndexChanged: (value) {
                      setState(() {
                        selectedClothesIndex = value;
                        selectedClothesForAdding =
                            state.clothes![value].idClothes!;

                        // Add GetClothesSizes and GetClothesColors events to the sizeBloc and colorBloc respectively
                        sizeBloc.add(GetClothesSizes(
                            id: state.clothes![value].idClothes!));
                        colorBloc.add(GetClothesColors(
                            id: state.clothes![value].idClothes!));
                      });
                    },
                    isColorDropdown: false,
                  ),
                  // Build the sizes dropdown menu
                  _buildSizesDropdown(),
                  // Build the colors dropdown menu
                  _buildColorDropdown()
                ],
              );

            // Return an empty SizedBox if the state is not RemoteClothesLoading or RemoteClothesDone
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  /// Adds a new item to the shop by calling the [AddShopGarnish] event
  /// with the details of the item to be added. Then it shows a success
  /// snackbar and navigates back to the director clothes screen.
  ///
  /// This function does not return anything.
  void _addToShop() async {
    // Set the details of the item to be added to the shop
    newShopGarnish.colorClothesId = colorForAdding!;
    newShopGarnish.sizeClothesId = sizeForAdding!;
    newShopGarnish.shopId = int.parse(SessionStorage.getValue("shopAddressId"));
    newShopGarnish.quantity = int.parse(quantity.text);

    // Add the item to the shop
    service<RemoteShopGarnishBloc>()
        .add(AddShopGarnish(shopGarnishDTO: newShopGarnish));

    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Show a success snackbar
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.current.itemAdded),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    // Navigate back to the director clothes screen
    router.pop();
    router.push(
      Pages.directorClothes.screenPath,
    );
  }

  /// Checks if the item to be added already exists in the shop.
  ///
  /// This function returns a [Future] that resolves to a [bool] indicating
  /// whether the item already exists or not.
  ///
  /// It does this by adding a [GetShopGarnish] event to the
  /// [RemoteShopGarnishBloc] service, requesting the shop garnish for the
  /// current shop. Then it filters the shop garnish to see if there is any
  /// garnish with the same color, size and clothes as the item to be added.
  /// The function returns [true] if such garnish exists, [false] otherwise.
  Future<bool> _checkIfExists() async {
    // Get the shop garnish bloc service
    var shopGarnishBloc = service<RemoteShopGarnishBloc>();

    // Add a GetShopGarnish event to get the shop garnish
    shopGarnishBloc.add(GetShopGarnish(
        id: int.parse(SessionStorage.getValue("shopAddressId"))));

    // Map the stream of events to a bool indicating if the garnish exists
    return shopGarnishBloc.stream.map((event) {
      if (event is RemoteShopGarnishDone) {
        // Check if any garnish in the shop has the same color, size and clothes
        return event.shopGarnish!.any((element) =>
            element.colorClothesGarnish!.id == colorForAdding &&
            element.sizeClothesGarnish!.id == sizeForAdding &&
            element.sizeClothesGarnish!.clothes!.idClothes ==
                selectedClothesForAdding);
      }
      // If the event is not a RemoteShopGarnishDone, return false
      return false;
    }).first;
  }

  /// Builds and returns a [Widget] representing the "Add Clothes to Shop" button.
  ///
  /// This button, when pressed, checks if the clothes to be added already exist
  /// in the shop. If they do, a snackbar is shown indicating that the item
  /// already exists. If they don't, the [_addToShop] function is called.
  Widget _buildAddClothesButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          // Check if the item to be added already exists in the shop
          ifExists = await _checkIfExists();

          if (ifExists) {
            // If the item already exists, show a snackbar
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.current.itemAlreadyExists),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          } else {
            // If the item doesn't exist, add it to the shop
            _addToShop();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBrown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: BaseButtonText(title: S.current.addNewClothesToShop),
      ),
    );
  }

  /// Builds the color dropdown widget.
  ///
  /// This function uses the BlocProvider and BlocBuilder widgets to provide
  /// and listen to changes in the [colorBloc]. It returns a [BasicDropdown]
  /// widget that displays a dropdown list of colors retrieved from the
  /// [RemoteClothesState].
  Widget _buildColorDropdown() {
    // Use BlocProvider to provide the colorBloc to its child.
    return BlocProvider<RemoteClothesBloc>(
      create: (context) => colorBloc,
      // Use BlocBuilder to listen to changes in the colorBloc.
      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
        builder: (context, state) {
          // Switch on the runtime type of the state to handle different states.
          switch (state.runtimeType) {
            // If the state is RemoteClothesLoading, return an empty SizedBox.
            case RemoteClothesLoading:
              return const SizedBox();
            // If the state is RemoteClothesColorsDone, return a BasicDropdown
            // widget with the clothes colors data.
            case RemoteClothesColorsDone:
              return BasicDropdown(
                // Title of the dropdown list.
                listTitle: S.current.chooseColor,
                // Data for the dropdown list.
                dropdownData: state.clothesColors!
                    .map((e) => e.colors!.nameColor ?? "")
                    .toList(),
                // Data for the color dropdown.
                colorDropdownData: state.clothesColors!
                    .map((e) => e.colors!.hex ?? "")
                    .toList(),
                // Selected index of the dropdown list.
                selectedIndex: selectedColorIndex!,
                // Callback function when the dropdown list index is changed.
                onIndexChanged: (value) {
                  // Update the selectedColorIndex and colorForAdding variables.
                  setState(() {
                    selectedColorIndex = value;
                    colorForAdding = state.clothesColors![value].id;
                  });
                },
                // Indicates if the dropdown is a color dropdown.
                isColorDropdown: true,
              );
            // If the state is not RemoteClothesLoading or RemoteClothesColorsDone,
            // return an empty SizedBox.
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  /// Builds a widget that displays a dropdown menu for selecting sizes.
  ///
  /// This widget uses the BlocProvider and BlocBuilder widgets to listen to
  /// changes in the RemoteClothesBloc state and update the dropdown menu
  /// accordingly.
  Widget _buildSizesDropdown() {
    // Use BlocProvider to create a RemoteClothesBloc instance and add a
    // GetClothesSizes event to the sizeBloc.
    return BlocProvider<RemoteClothesBloc>(
      create: (context) => sizeBloc,
      // Use BlocBuilder to listen to changes in the RemoteClothesBloc state.
      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
        builder: (context, state) {
          // Handle the different states of the RemoteClothesBloc.
          switch (state.runtimeType) {
            // If the state is RemoteClothesLoading, return an empty SizedBox.
            case RemoteClothesLoading:
              return const SizedBox();
            // If the state is RemoteClothesSizeClothesDone, return a BasicDropdown
            // widget with the clothes size data.
            case RemoteClothesSizeClothesDone:
              return BasicDropdown(
                // Title of the dropdown list.
                listTitle: S.current.chooseSize,
                // Data for the dropdown list.
                dropdownData: state.clothesSizeClothes!
                    .map((e) => e.sizeClothes!.nameSize ?? "")
                    .toList(),
                // Selected index of the dropdown list.
                selectedIndex: selectedSizeIndex!,
                // Callback function when the dropdown list index is changed.
                onIndexChanged: (value) {
                  // Update the selectedSizeIndex and sizeForAdding variables.
                  setState(() {
                    selectedSizeIndex = value;
                    sizeForAdding =
                        state.clothesSizeClothes![selectedSizeIndex!].id;
                  });
                },
                // Indicates if the dropdown is a color dropdown.
                isColorDropdown: false,
              );
            // If the state is not RemoteClothesLoading or RemoteClothesSizeClothesDone,
            // return an empty SizedBox.
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
